//
//  Float.swift
//  Login
//
//  Created by Sujan Vaidya on 7/26/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

public protocol FloatLimitValidator: Validator {
  var minQuantity: Float { get }
  var maxQuantity: Float { get }
  var error: Error { get }
}

public extension FloatLimitValidator {
  func validate<T>(_ value: T) -> ValidationResult<T> {
    guard let floatValue = value as? Float else { return .error(nil) }
    return floatValue >= minQuantity && floatValue <= maxQuantity ?
      .ok(value) :
      .error(error)
  }
}

public protocol FloatPrecisionValidator: Validator {
  var precisionLength: Int { get }
  var error: Error { get }
}

public extension FloatPrecisionValidator {
  func validate<T>(_ value: T) -> ValidationResult<T> {
    guard let floatValue = value as? Float else { return .error(nil) }
    return floatValue.precisionCount <= precisionLength ?
      .ok(value) :
      .error(error)
  }
}

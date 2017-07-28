//
//  StringLength.swift
//  Login
//
//  Created by Sujan Vaidya on 7/24/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

public protocol StringLengthValidator: Validator {
  var minLength: Int { get }
  var maxLength: Int { get }
  var error: Error { get }
}

public extension StringLengthValidator {
  func validate<T>(_ value: T) -> ValidationResult<T> {
    guard let stringValue = value as? String else { return .error(nil) }
    return stringValue.characters.count >= minLength && stringValue.characters.count <= maxLength ?
      .ok(value) :
      .error(error)
  }
}

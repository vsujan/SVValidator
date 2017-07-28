//
//  CharactetSet.swift
//  Login
//
//  Created by Sujan Vaidya on 7/24/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

public protocol CharacterSetValidator: Validator {
  var characterCase: CharacterSet { get }
  var error: Error { get }
}

public extension CharacterSetValidator {
  func validate<T>(_ value: T) -> ValidationResult<T> {
    guard let stringValue = value as? String else { return .error(nil) }
    return stringValue.rangeOfCharacter(from: characterCase) != nil ?
      .ok(value) :
      .error(error)
  }
  
}

public protocol CharacterSetExclusiveValidator: Validator {
  var characterCase: CharacterSet { get }
  var error: Error { get }
}

public extension CharacterSetExclusiveValidator {
  func validate<T>(_ value: T) -> ValidationResult<T> {
    guard let stringValue = value as? String else { return .error(nil) }
    return stringValue.rangeOfCharacter(from: characterCase) == nil ?
      .ok(value) :
      .error(error)
  }
  
}

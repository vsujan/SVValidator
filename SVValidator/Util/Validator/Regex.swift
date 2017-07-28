//
//  Regex.swift
//  Login
//
//  Created by Sujan Vaidya on 7/24/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

public protocol RegexValidator: Validator {
  var REGEX: String { get }
  var error: Error { get }
}

public extension RegexValidator {
  func validate<T>(_ value: T) -> ValidationResult<T> {
    let test = NSPredicate(format:"SELF MATCHES %@", self.REGEX)
    guard let stringValue = value as? String else { return .error(nil) }
    return test.evaluate(with: stringValue) ?
      .ok(value) :
      .error(self.error)
    
  }
}

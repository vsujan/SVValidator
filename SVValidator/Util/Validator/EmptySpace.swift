//
//  EmptySpace.swift
//  Login
//
//  Created by Sujan Vaidya on 7/25/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

public protocol EmptySpaceValidator: Validator {
  var error: Error { get }
}

public extension EmptySpaceValidator {
  func validate<T>(_ value: T) -> ValidationResult<T> {
    guard let stringValue = value as? String else { return .error(nil) }
    return !stringValue.hasEmptySpaceAtBeg ?
      .ok(value) :
      .error(self.error)
  }
}

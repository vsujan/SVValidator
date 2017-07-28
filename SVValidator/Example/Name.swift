//
//  Name.swift
//  Login
//
//  Created by Sujan Vaidya on 7/26/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

enum NameValidationError: Error {
  case empty
  case invalidFormat
  case length
}

let STRING_REGEX = "^[a-zA-Z]+( [a-zA-Z]+)*$"

extension NameValidationError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .empty: return NSLocalizedString("Empty string not allowed", comment: "Empty string")
    case .invalidFormat: return NSLocalizedString("The format is not valid", comment: "Invalid format")
    case .length: return NSLocalizedString("The length is not allowed", comment: "Invalid length")
    }
  }
}

class NameEmptyValidator: EmptyValidator {
  let error: Error
  
  init(error: Error = NameValidationError.empty) {
    self.error = error
  }
  
}

class NameFormatValidator: RegexValidator {
  let REGEX: String
  let error: Error
  
  init(regex: String = STRING_REGEX, error: Error = NameValidationError.invalidFormat) {
    self.REGEX = regex
    self.error = error
  }
  
}

class NameLengthValidator: StringLengthValidator {
  var minLength: Int
  var maxLength: Int
  var error: Error
  static let minAllowedLength = 0
  static let maxAllowedLength = 100
  
  init(min: Int = minAllowedLength, max: Int = maxAllowedLength, error: Error = NameValidationError.length) {
    self.minLength = min
    self.maxLength = max
    self.error = error
  }
}

class NameValidator: CompositeValidator {
  let validators: [Validator]
  
  init(regex: String = STRING_REGEX) {
    self.validators = [
      NameEmptyValidator(),
      NameFormatValidator(regex: regex),
      NameLengthValidator()
    ]
  }
}

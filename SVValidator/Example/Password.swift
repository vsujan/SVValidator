//
//  Password.swift
//  Login
//
//  Created by Sujan Vaidya on 7/24/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

enum PasswordValidationError: Error {
  case empty
  case weak(reasoning: [PasswordStrengthValidationError])
}

let PASSWORD_MIN_LENGTH = 8
let PASSWORD_MAX_LENGTH = 14
let PASSWORD_SPECIAL_CHARSET = CharacterSet(charactersIn: "!@#$%^&*()")

extension PasswordValidationError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .empty: return NSLocalizedString("Password field cannot be empty", comment: "Empty password")
    case .weak: return NSLocalizedString("Password format is weak", comment: "Invalid format")
    }
  }
}

enum PasswordStrengthValidationError: Error {
  case length
  case missingUppercase
  case missingLowercase
  case missingNumber
  case missingSpecialCharacter
}

extension PasswordStrengthValidationError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .length: return NSLocalizedString("Password length is invalid", comment: "Invalid length")
    case .missingUppercase: return NSLocalizedString("Password does not contain uppercase", comment: "Invalid format")
    case .missingLowercase: return NSLocalizedString("Password does not contain lowercase", comment: "Invalid format")
    case .missingNumber: return NSLocalizedString("Password does not contain number", comment: "Invalid format")
    case .missingSpecialCharacter: return NSLocalizedString("Password does not contain special character", comment: "Invalid format")
    }
  }
}

class PasswordEmptyValidator: EmptyValidator {
  let error: Error
  
  init(error: Error = PasswordValidationError.empty) {
    self.error = error
  }
  
}

class PasswordLengthValidator: StringLengthValidator {
  var minLength: Int
  var maxLength: Int
  var error: Error
  
  init(minLength: Int = PASSWORD_MIN_LENGTH, maxLength: Int = PASSWORD_MAX_LENGTH, error: Error = PasswordStrengthValidationError.length) {
    self.minLength = minLength
    self.error = error
    self.maxLength = maxLength
  }
}

class PasswordIncludesUppercaseValidator: CharacterSetValidator {
  let characterCase: CharacterSet
  let error: Error
  
  init(characterCase: CharacterSet = NSCharacterSet.uppercaseLetters, error: Error = PasswordStrengthValidationError.missingUppercase) {
    self.characterCase = characterCase
    self.error = error
  }
  
}

class PasswordIncludesLowercaseValidator: CharacterSetValidator {
  let characterCase: CharacterSet
  let error: Error
  
  init(characterCase: CharacterSet = NSCharacterSet.lowercaseLetters, error: Error = PasswordStrengthValidationError.missingLowercase) {
    self.characterCase = characterCase
    self.error = error
  }
  
}

class PasswordIncludesNumbersValidator: CharacterSetValidator {
  let characterCase: CharacterSet
  let error: Error
  
  init(characterCase: CharacterSet = NSCharacterSet.decimalDigits, error: Error = PasswordStrengthValidationError.missingNumber) {
    self.characterCase = characterCase
    self.error = error
  }
  
}

class PasswordIncludesSpecialCharacterValidator: CharacterSetValidator {
  var characterCase: CharacterSet
  var error: Error
  
  init(charSet: CharacterSet = PASSWORD_SPECIAL_CHARSET, error: Error = PasswordStrengthValidationError.missingSpecialCharacter) {
    self.characterCase = charSet
    self.error = error
  }
}

class PasswordStrengthValidator: CompositeValidator {
  let validators: [Validator]
  
  init(minLength: Int = PASSWORD_MIN_LENGTH, maxLength: Int = PASSWORD_MAX_LENGTH, charSet: CharacterSet = PASSWORD_SPECIAL_CHARSET) {
    self.validators = [
      PasswordLengthValidator(minLength: minLength, maxLength: maxLength),
      PasswordIncludesUppercaseValidator(),
      PasswordIncludesLowercaseValidator(),
      PasswordIncludesNumbersValidator(),
      PasswordIncludesSpecialCharacterValidator(charSet: charSet)
    ]
  }
  
}

class PasswordValidator: CompositeValidator {
  let validators: [Validator]
  
  init(minLength: Int = PASSWORD_MIN_LENGTH, maxLength: Int = PASSWORD_MAX_LENGTH, charSet: CharacterSet = PASSWORD_SPECIAL_CHARSET) {
    self.validators = [
      PasswordEmptyValidator(),
      PasswordStrengthValidator(minLength: minLength, maxLength: maxLength, charSet: charSet)
    ]
  }
}

//
//  Quantity.swift
//  Login
//
//  Created by Sujan Vaidya on 7/26/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

enum QuantityValidationError: Error {
  case limit
  case precision
}

let QUANTITY_MIN: Float = 0
let QUANTITY_MAX: Float = 10
let QUANTITY_PRECISION = 2

extension QuantityValidationError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .limit: return NSLocalizedString("The quantity is not allowed", comment: "Invalid quantity")
    case .precision: return NSLocalizedString("The precision is not allowed", comment: "Invalid precision")
    }
  }
}

class QuantityLimitValidator: FloatLimitValidator {
  var minQuantity: Float
  var maxQuantity: Float
  var error: Error
  
  init(min: Float = QUANTITY_MIN, max: Float = QUANTITY_MAX, error: Error = QuantityValidationError.limit) {
    self.minQuantity = min
    self.maxQuantity = max
    self.error = error
  }
}

class QuantityPrecisionValidator: FloatPrecisionValidator {
  var precisionLength: Int
  var error: Error
  
  init(precisionLength: Int = QUANTITY_PRECISION, error: Error = QuantityValidationError.precision) {
    self.precisionLength = precisionLength
    self.error = error
  }
}

class QuantityValidator: CompositeValidator {
  var validators: [Validator]
  
  init(max: Float = QUANTITY_MAX, min: Float = QUANTITY_MIN, precision: Int = QUANTITY_PRECISION) {
    
    self.validators = [QuantityLimitValidator(min: min, max: max), QuantityPrecisionValidator(precisionLength: precision)]
  }
}

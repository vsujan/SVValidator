# SVValidator
A validator to validate form inputs.

## Installation

### Cocoapods
	pod 'SVValidator'

### Carthage
	github 'vsujan92/SVValidator'

## Features
1) [Characterset validation](#validate-characterset)
2) [Empty string validation](#validate-empty-string)
3) [Empty space at beginning validation](#validate-space-at-the-beginning)
4) [Quantity limit validation](#validate-quantity-limit)
5) [Quantity precision validation](#validate-quantity-precision)
6) [Regex validation](#validate-string-against-regex)
7) [String length validation](#validate-string-length)

## Technical Documentation

### Validate characterset

```swift
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
```

### Validate empty string

```swift
public protocol EmptyValidator: Validator {
  var error: Error { get }
}

public extension EmptyValidator {
  func validate<T>(_ value: T) -> ValidationResult<T> {
    guard let stringValue = value as? String else { return .error(nil) }
    return stringValue.isEmpty ? .error(error) : .ok(value)
  }
}
```

### Validate space at the beginning

```swift
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
```

### Validate quantity limit

```swift
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
```

### Validate quantity precision

```swift
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
```

### Validate string against regex

```swift
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

```

### Validate string length

```swift
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
```

## Example
Email validation

```swift
import UIKit

enum EmailValidationError: Error {
  case empty
  case invalidFormat
}

let EMAIL_REGEX = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"

extension EmailValidationError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .empty: return NSLocalizedString("Email field cannot be empty", comment: "Empty email")
    case .invalidFormat: return NSLocalizedString("Email format is not valid", comment: "Invalid format")
    }
  }
}

class EmailEmptyValidator: EmptyValidator {
  let error: Error
  
  init(error: Error = EmailValidationError.empty) {
    self.error = error
  }
  
}

class EmailFormatValidator: RegexValidator {
  let REGEX: String
  let error: Error
  
  init(regex: String = EMAIL_REGEX, error: Error = EmailValidationError.invalidFormat) {
    self.REGEX = regex
    self.error = error
  }
  
}

class EmailValidator: CompositeValidator {
  let validators: [Validator]
  
  init(regex: String = EMAIL_REGEX) {
    self.validators = [
      EmailEmptyValidator(),
      EmailFormatValidator(regex: regex)
    ]
  }
}

let emailValidator = EmailValidator()
let emailValue = "hello@world.com"
emailValidator.validate(emailValue)
```

## License
SVValidator is released under MIT license.

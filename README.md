# SVValidator

A validator to validate form inputs.

## Installation

### Cocoapods
	
	pod 'SVValidator'

### Carthage
	
	github 'vsujan92/SVValidator'

## Usage

   ```swift
   	  enum EmailValidationError: Error {
  	  	case empty
      	case invalidFormat
	  	}

	  extension EmailValidationError: LocalizedError {
  	  public var errorDescription: String? {
    	  switch self {
    			case .empty: return NSLocalizedString("Email field cannot be empty", comment: "Empty email")
    			case .invalidFormat: return NSLocalizedString("Email format is not valid", comment: "Invalid format")
    		}
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
		```swift



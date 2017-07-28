//
//  TextField+Extension.swift
//  Login
//
//  Created by Sujan Vaidya on 7/19/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

struct AssociatedKeys {
  static var type: UInt8 = 0
}

extension UITextField {
  var type: TextFieldType {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.type, defaultValue: .unknown)
    }
    set(newValue) {
      objc_setAssociatedObject(self, &AssociatedKeys.type, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  func objc_getAssociatedObject<T>(_ object: Any!, _ key: UnsafeRawPointer!, defaultValue: T) -> T {
    guard let value = ObjectiveC.objc_getAssociatedObject(object, key) as? T else {
      return defaultValue
    }
    return value
  }
}

enum TextFieldType {
  case email
  case password
  case name
  case quantity
  case unknown
}

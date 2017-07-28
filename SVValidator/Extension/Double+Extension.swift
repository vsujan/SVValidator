//
//  Double+Extension.swift
//  Login
//
//  Created by Sujan Vaidya on 7/25/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

extension Double {
  var precisionCount: Int {
    let stringValue = String(self)
    let needle: Character = "."
    let pos = stringValue.positionOfChar(char: needle);
    return stringValue.characters.count - pos! - 1
  }
}

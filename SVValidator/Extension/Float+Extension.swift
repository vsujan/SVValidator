//
//  Float+Extension.swift
//  Login
//
//  Created by Sujan Vaidya on 7/26/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

extension Float {
  var precisionCount: Int {
    let stringValue = String(self)
    let needle: Character = "."
    let pos = stringValue.positionOfChar(char: needle);
    return stringValue.characters.count - pos! - 1
  }
}


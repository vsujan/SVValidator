//
//  String+Extension.swift
//  Login
//
//  Created by Sujan Vaidya on 7/25/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

extension String {
  var hasEmptySpaceAtBeg: Bool {
    let needle: Character = " "
    let pos = self.positionOfChar(char: needle)
    return pos == 0 ? true : false
  }
  
  // For single word
  var hasEmptySpaceAtEnd: Bool {
    let needle: Character = " "
    let pos = self.positionOfChar(char: needle)
    return pos == self.characters.count - 1 ? true : false
  }
  
  // Returns first position of the occurrence of the character
  func positionOfChar(char: Character) -> Int? {
    if let idx = self.characters.index(of: char) {
      let pos = self.characters.distance(from: self.startIndex, to: idx)
      return pos
    } else {
      return nil
    }
  }
  
  var condenseWhitespace: String {
    let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
    return components.filter { !$0.isEmpty }.joined(separator: " ")
  }
  
  var floatValue: Float? {
    if let value = Float(self) {
      return value
    }
    return nil
  }
}

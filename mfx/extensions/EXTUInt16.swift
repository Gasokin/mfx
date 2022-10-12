//
//  EXTUInt16.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/06/07.
//

import Foundation

extension UInt16 {
  
  func equals(_ values: UInt16...) -> Bool {
    
    for value in values {
      if self == value {
        return true
      }
    }
    
    return false
  }
  
}

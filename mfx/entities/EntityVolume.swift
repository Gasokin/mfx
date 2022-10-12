//
//  EntityVolume.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/05/03.
//

import Foundation

class EntityVolume {
  
  var name = ""
  var size_t = 0
  var size_u = 0
  var size_f = 0

  func chain(_ closure: (Self) -> Void) -> Self {
    closure(self)
    return self
  }
  
  var toString: String {
    get {
      return "VolumeName = \(name)  Total: \(Units(size_t).Auto)    Use: \(Units(size_u).Auto)   Free: \(Units(size_f).Auto)"
    }
  }
}

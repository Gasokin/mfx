//
//  EntityInfoDir.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/09/21.
//

import Foundation
import os

class EntityInfoDir {
  
  let size: Int
  let count: [Int]
  
  init(_ size: Int,_ count: [Int]) {
    self.size = size
    self.count = count
  }
  
  func toString() -> String {
    let r = Units(size).Auto
    + "  Dir: " + String(count[Consts.TypeObj.D.rawValue])
          + "  File: " + String(count[Consts.TypeObj.F.rawValue])
          + "  Link/Ailas: " + String(count[Consts.TypeObj.L.rawValue] + count[Consts.TypeObj.A.rawValue])
   return r
  }
}

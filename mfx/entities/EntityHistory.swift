//
//  EntityHistory.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/04/24.
//

import Foundation

class EntityHistory {
  
  var url: URL!
  var name: String!
  var index: Int!

  func chain(_ closure: (Self) -> Void) -> Self {
    closure(self)
    return self
  }

}

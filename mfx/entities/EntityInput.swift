//
//  EntityInput.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/09/20.
//

import Foundation

class EntityInput {
  
  var subject: String!
  var comment: String!
  var success: Optional<(String) -> ()> = nil
  var failure: Optional<(String) -> ()> = nil
  var elapsed: Optional<(String) -> ()> = nil

  /*
  @discardableResult
  func chain(_ closure: (Self) -> Void) -> Self {
    closure(self)
    return self
  }
  */

}

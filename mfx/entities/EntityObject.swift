//
//  EntityDisplay.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/09/03.
//

import Foundation
import AppKit

class EntityObject {
  
  let url: URL
  let type: Consts.TypeObj

  var mark: Bool
  
  var icon: NSImage!
  var name: String!
  var ext: String!
  var date: Date!
  var size: Int!
  var perm: String!
  var type_string: String!
  
  init(_ u: URL,_ t: Consts.TypeObj) {
    url = u
    type = t
    mark = false
  }

}

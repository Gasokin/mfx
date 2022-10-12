//
//  ConfigDraw.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/09/19.
//

import Foundation
import os
import AppKit

class ConfigDraw {

  var width = 0.0
  var dir = DrawObject()
  var file = DrawObject()

}

struct DrawObject {
  var x = DrawItem()
  var w = DrawItem()
  var r = DrawRect()
}

struct DrawItem {
  var icon = 0.0
  var name = 0.0
  var ext = 0.0
  var size = 0.0
  var date = 0.0
}

struct DrawRect {
  var icon = NSRect()
  var name = NSRect()
  var ext = NSRect()
  var size = NSRect()
  var date = NSRect()
}


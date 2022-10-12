//
//  TableRowView.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/08/30.
//

import Cocoa

class TableRowView: NSTableRowView {
  
  let LINE_HEIGHT = 2.0
  
  private var _responder = false
  
  var firstResponder: Bool {
    get {return _responder}
    set {
      _responder = newValue
    }
  }
  
  override func drawSelection(in dirtyRect: NSRect) {
    
    if !_responder {
      return
    }

    // 下線を引くだけ
    let line = NSMakeRect(0, dirtyRect.height - LINE_HEIGHT, dirtyRect.maxX, LINE_HEIGHT)
    NSColor(hex: "FF7F7F", alpha: 1.0).setFill()
    line.fill()
  }
}

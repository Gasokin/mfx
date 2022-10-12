//
//  TableView.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/08/30.
//

import Cocoa
import os

class TableView: NSTableView {
  
  var _responder = false
  
  override func mouseDown(with event: NSEvent) {
    // マウス操作は無効にする
  }
  
  override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
    return false
  }
  
  override var acceptsFirstResponder: Bool {
    get {return _responder}
  }

  var firstResponder: Bool {
    get {return _responder}
    set {
      _responder = newValue
      
      guard let w = self.window else {
        OSLog.mfx.info("self.window is nil")
        return
      }
      
      _ = newValue ? w.makeFirstResponder(self) : w.resignFirstResponder()
    }
  }
  
}

//
//  MFXLine.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/01/04.
//

import Cocoa

class MFXLine: NSView {
  
  override func draw(_ dirtyRect: NSRect) {
    NSColor.lightGray.setFill()
    NSRect(x: 5, y: 1, width: dirtyRect.width - 10, height: 1).fill()
  }
}

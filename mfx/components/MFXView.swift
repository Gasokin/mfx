//
//  MFXView.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/05/04.
//

import Cocoa
import os

class MFXView: NSVisualEffectView {

  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)
    
    OSLog.mfx.info("draw Start")

//    NSColor(white: 0, alpha: 0.6).setFill()
//    dirtyRect.fill(using: .sourceOver)
    
//    layer?.cornerRadius = 10.0
    
  }
}

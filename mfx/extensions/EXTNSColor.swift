//
//  ENSColor.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/03/29.
//

import Foundation
import AppKit

extension NSColor {
  
  convenience init(hex: String, alpha: CGFloat = 1.0) {
      let v = Int("000000" + hex, radix: 16) ?? 0
      let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
      let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
      let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
      self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
  }

  func complement() -> NSColor { // 補色
    return NSColor(red: 0xFF - self.redComponent, green: 0xFF - self.greenComponent, blue: 0xFF - self.blueComponent,alpha: self.alphaComponent)
  }
  
}

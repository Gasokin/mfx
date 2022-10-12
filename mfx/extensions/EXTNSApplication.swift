//
//  EXTNSApplication.swift
//  mfx
//
//  Created by 平賀義紀 on 2021/12/30.
//

import Foundation
import Cocoa

extension NSApplication {
  
  public var isDarkMode: Bool {
    if #available(OSX 10.14, *) {
      let name = effectiveAppearance.name
      return name == .darkAqua
    }
    else {
      return false
    }
  }
}


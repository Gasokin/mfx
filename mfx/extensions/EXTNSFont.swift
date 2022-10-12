//
//  EXTNSFont.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/01/03.
//

import Foundation
import Cocoa

extension NSFont {

  var height: CGFloat {
    get {
      return "yYあ".heightOfString(usingFont: self)
    }
  }

  var widthPermission: CGFloat {
    get {
      return "rwxrwxrwx".widthOfString(usingFont: self)
    }
  }
  
  func width(_ value: String,kern: Int = 0) -> CGFloat {
    return value.widthOfString(usingFont: self,kern: kern)
  }
  
  func new(_ size: CGFloat) -> NSFont {
    return NSFont(name: self.fontName, size: size) ?? self
  }
  
  func new(_ value: ConfigItemFont) -> NSFont {
    return NSFont(name: value.Name,size: value.Size) ?? self
  }
  
  func plus(_ offset: CGFloat = 1) -> NSFont {
    if self.pointSize + offset < 1 {
      return self
    }
    return new(self.pointSize + offset)
  }

  func minus(_ offset: CGFloat = 1) -> NSFont {
    if self.pointSize - offset < 1 {
      return self
    }
    return new(self.pointSize - offset)
  }

}

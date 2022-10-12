//
//  DisplayFormatter.swift
//  mfx
//
//  Created by 平賀義紀 on 2021/03/17.
//

import Foundation
import Cocoa

class DisplayFormatter {
  
  let font: NSFont
  let color: NSColor

  init(_ font: NSFont,_ color: NSColor = NSColor.textColor) {
    self.font = font
    self.color = color
  }

  func leftClip(_ value: String,kern: Int = 0) -> NSAttributedString {
    return NSAttributedString(string: value, attributes: makeTextAttributeClip(font: font,align: .left, kern: kern))
  }

  func left(_ value: String,kern: Int = 0,_ breakmode: NSLineBreakMode = .byTruncatingMiddle) -> NSAttributedString {
    return NSAttributedString(string: value, attributes: textAttribute(align: .left, kern: kern,breakmode))
  }
  
  func right(_ value: String,kern: Int = 0) -> NSAttributedString {
    return NSAttributedString(string: value, attributes: textAttribute(align: .right, kern: kern))
  }
  
  func center(_ value: String,kern: Int = 0) -> NSAttributedString {
    return NSAttributedString(string: value, attributes: textAttribute(align: .center, kern: kern))
  }
  
  func string(_ value: String,kern: Int = 0,align: NSTextAlignment = .left) -> NSAttributedString {
    return NSAttributedString(string: value, attributes: textAttribute(align: align, kern: kern))
  }

  func textAttribute(align: NSTextAlignment,kern: Int,_ breakmode: NSLineBreakMode = .byTruncatingMiddle) -> [NSAttributedString.Key : Any] {
    let attributes: [NSAttributedString.Key : Any] = [
      .font: font,
      .kern: kern,
      .paragraphStyle: makeParagraph(align,breakmode),
      .foregroundColor: color,
    ]
    return attributes
  }

  func makeTextAttributeClip(font: NSFont,align: NSTextAlignment = .left,kern: Int = -1) -> [NSAttributedString.Key : Any] {
    let attributes: [NSAttributedString.Key : Any] = [
      .font: font,
      .kern: kern,
      .paragraphStyle: makeParagraphClip(align),
      .foregroundColor: color,
    ]
    return attributes
  }

  func makeParagraph(_ alignment: NSTextAlignment = .left,_ breakmode: NSLineBreakMode = .byTruncatingMiddle) -> NSMutableParagraphStyle {
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = alignment
    paragraph.lineBreakMode = breakmode
    paragraph.allowsDefaultTighteningForTruncation = false
    return paragraph
  }

  func makeParagraphClip(_ alignment: NSTextAlignment = .left) -> NSMutableParagraphStyle {
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = alignment
    paragraph.lineBreakMode = .byCharWrapping
    paragraph.lineBreakStrategy = .standard
    paragraph.allowsDefaultTighteningForTruncation = false
    return paragraph
  }
}

//
//  EXTString.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/01/03.
//

import Foundation
import Cocoa

extension String {
  
  public func widthOfString(usingFont font: NSFont,kern: Int = 0) -> CGFloat {
    let attributes = [NSAttributedString.Key.font: font,NSAttributedString.Key.kern: kern] as [NSAttributedString.Key : Any]
    let size = self.size(withAttributes: attributes)
    return size.width
  }
  
  public func heightOfString(usingFont font: NSFont) -> CGFloat {
    let attributes = [NSAttributedString.Key.font: font]
    let size = self.size(withAttributes: attributes)
    return size.height
  }
  
  func contain(pattern: String) -> Bool {
    guard let regex = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options()) else {
      return false
    }
    return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, self.count)) != nil
  }
  
  /// 文字列がしていれた文字列のいずれかを含むかを返す
  /// - Parameter values: 検査したい文字列
  /// - Returns: 検査したい文字列のいずれかが含まれていればtrue,含まれていなければfalse
  public func contains(_ values: [String]) -> Bool {
    var r = false
    values.forEach({
      if self.contains($0) {
        r = true
        return
      }
    })
    return r
  }
  
  /// Index with using position of Int type
  func index(at position: Int) -> String.Index {
    return index((position.signum() >= 0 ? startIndex : endIndex), offsetBy: position)
  }
  
  /// Subscript for using like a "string[i]"
  subscript (position: Int) -> String {
    let i = index(at: position)
    return String(self[i])
  }
  
  /// Subscript for using like a "string[start..<end]"
  subscript (bounds: CountableRange<Int>) -> String {
    let start = index(at: bounds.lowerBound)
    let end = index(at: bounds.upperBound)
    return String(self[start..<end])
  }
  
  /// Subscript for using like a "string[start...end]"
  subscript (bounds: CountableClosedRange<Int>) -> String {
    let start = index(at: bounds.lowerBound)
    let end = index(at: bounds.upperBound)
    return String(self[start...end])
  }
  
  /// Subscript for using like a "string[..<end]"
  subscript (bounds: PartialRangeUpTo<Int>) -> String {
    let i = index(at: bounds.upperBound)
    return String(prefix(upTo: i))
  }
  
  /// Subscript for using like a "string[...end]"
  subscript (bounds: PartialRangeThrough<Int>) -> String {
    let i = index(at: bounds.upperBound)
    return String(prefix(through: i))
  }
  
  /// Subscript for using like a "string[start...]"
  subscript (bounds: PartialRangeFrom<Int>) -> String {
    let i = index(at: bounds.lowerBound)
    return String(suffix(from: i))
  }
}

//
//  Nums.swift
//  mfx
//
//  Created by 平賀義紀 on 2021/11/10.
//

import Foundation

class Nums {
  
  /// 数字から文字列に変換する
  /// - Parameter num: 変換元の数字
  /// - Returns: 変換後の文字列
  static func toString(_ num: Int?,_ format: String = "%qu") -> String {
    
    guard let n = num else {
      return "Unkown Number"
    }
    
    return String.localizedStringWithFormat(format, n)
  }
  
  static func toString(_ nums: [Int],_ format: String = "%d") -> [String] {
    
    var r = [String]()
    for num in nums {
      r.append(String.localizedStringWithFormat(format, num))
    }
    
    return r
  }

  static func toString(_ num: CGFloat?,_ format: String = "%qu") -> String {
    
    guard let n = num else {
      return "Unkown Number"
    }
    
    return String.localizedStringWithFormat(format, n)
  }
  

  static func max(_ nums: CGFloat...) -> CGFloat {
    
    var r = CGFloat.leastNormalMagnitude
    for num in nums {
      if num > r {
        r = num
      }
    }
    
    return r
  }
}

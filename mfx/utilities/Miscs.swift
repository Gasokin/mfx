//
//  Miscs.swift
//  mfx
//
//  Created by 平賀義紀 on 2021/11/16.
//

import Foundation

/// 雑多な処理を集めたクラス
class Miscs {
  
  /// Bool? を Bool に変換する
  /// - Parameter value: 変換元の Bool?
  /// - Returns: 変換後の Bool,valueがnilの場合はfalse.
  static func unwrap(_ value: Bool?) -> Bool {
    return value ?? false
  }

  
}

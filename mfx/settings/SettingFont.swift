//
//  SettingFont.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/03/04.
//

import Foundation
import Cocoa

/// フォントに関する設定を集めたクラス
class SettingFont {
  
  /// 左右リストのフォント
  var lists = [Defs.font.listL,Defs.font.listR]

  /// メッセージフォント
  var message = Defs.font.message
}

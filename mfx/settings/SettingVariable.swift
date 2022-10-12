//
//  Settings.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/02/20.
//

import Foundation


/// ユーザが設定可能なオプションを集めたクラス
class SettingVariable {
  
  /// 画面の見た目に関する設定
  let Styles = SettingStyles()
  let Fonts = SettingFont()
  
  static let i = SettingVariable()
  private init() {}
}

//
//  SettingInternal.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/03/04.
//

import Foundation

/// アプリの内部状態を集めたクラス
class Status {
  
  /// 現在カーソルのあるリストの左右
  var active: Consts.Area = .ListL
  
  /// リストの描画領域の大きさ
  let RectList: [EntityRectList] = [EntityRectList(),EntityRectList()]
  
  /// 今年の年
  let CurrentYear: Int
  
  static let i = Status()
  private init() {
    CurrentYear = Calendar.current.component(.year, from: Date())
  }
}

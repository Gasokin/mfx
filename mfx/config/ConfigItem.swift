//
//  ConfigItem.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/07/03.
//

import Foundation
import AppKit

/// アプリケーションの設定を保持する
struct ConfigItem: Codable {
  
  var DetailName = ConfigItemControl()
  var DetailInfo = ConfigItemControl()
  var Message = ConfigItemControl()
  var left = ConfigItemViewObject()
  var right = ConfigItemViewObject()

}

/// オブジェクトビューの設定を保持する
struct ConfigItemViewObject: Codable {
  var url: URL?
  var volume = ConfigItemControl()
  var list = ConfigItemControl()
  var info = ConfigItemControl()
  var mark = ConfigItemControl()
  var filter = ""
  var sort_item = ""
  var sort_order = ""
}

/// 詳細表示領域の設定を保持する
struct ConfigItemControl: Codable {
  public var Font = ConfigItemFont()
}

/// 詳細表示領域の設定を保持する
struct ConfigItemDetail: Codable {
  public var Font = ConfigItemFont()
}

/// ボリューム表示部の設定を保持する
struct ConfigItemVolume: Codable {
  public var Font = ConfigItemFont()
}

/// リスト部の設定を保持する
struct ConfigItemList: Codable {
  public var Font = ConfigItemFont()
}

/// ディレクトリ情報部の設定を保持する
struct ConfigItemInfo: Codable {
  public var Font = ConfigItemFont()
}

/// マーク情報部の設定を保持する
struct ConfigItemMark: Codable {
  public var Font = ConfigItemFont()
}

/// メッセージ部の設定を保持する
struct ConfigItemMessage: Codable {
  public var Font = ConfigItemFont()
}

/// フォントの設定を保持する
struct ConfigItemFont: Codable {
  public var Name = Mac.i.fontMono.fontName
  public var Size = Mac.i.fontMono.pointSize
  
  public var font: NSFont {
    get {
      return Mac.i.fontMono.new(self)
    }
  }
}


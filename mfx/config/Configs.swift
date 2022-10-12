//
//  Configs.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/07/02.
//

import Foundation

class Configs {
  
  var item = ConfigItem()
  var draw = ConfigDraw()
  
  static let i = Configs()
  private init() {}
  
  /// 設定ファイルのフルパスを返す
  var file: URL? {
    get {
      guard let dir = Mac.i.appSupport else {
        return nil
      }
      return dir.appendingPathComponent("mfx.conf")
    }
  }
  
  /// 設定内容をファイルに保存する
  func save() {
    
    guard let url = file else {
      return
    }
    
    let enc = JSONEncoder()
    enc.outputFormatting = [.prettyPrinted,.sortedKeys,.withoutEscapingSlashes]
    if let json = try? enc.encode(item) {
      do {
        try json.write(to: url)
      } catch let error {
        print(error)
      }
    }
    
  }
  
  /// 設定ファイルから読み込む
  func load() {
    
    guard let url = file else {
      return
    }
    
    do {
      let json = try Data(contentsOf: url)
      if let _item = try? JSONDecoder().decode(ConfigItem.self, from: json) {
        item = _item
      }
    } catch let error {
      print(error)
    }
  }
  
}

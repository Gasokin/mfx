//
//  Api.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/06/09.
//

import Foundation

protocol VcMainAPI {
  
  var viewActive: ViewObject {get}
  var viewDeActive: ViewObject {get}

  /// メッセージビューにメッセージを追加する
  var message: String {get set}
  
  /// カーソルがある行のオブジェクト情報を表示する
  func setDetail()

  /// 指定されたオブジェクトの情報を表示する
  /// - Parameter entity: オブジェクト
  func setDetail(_ entity: EntityObject?)
  
  /// アクセス許可用のフォルダ選択画面を開く
  /// - Parameter u: 許可したいURL
  /// - Returns: true: 許可、false: 不許可
  func dispOpenPanel(_ u: URL) -> URL?
  
  func setObjectMask(_ item: String)
  
  func remove()
  
  func copy()
  
}

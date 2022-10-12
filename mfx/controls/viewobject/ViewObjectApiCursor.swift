//
//  ViewObjectCursor.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/09/05.
//

import Foundation
import Cocoa
import os

extension ViewObject: ViewObjectApiCursor {

  /// カーソルを設定する
  /// - Parameter row: 設定する行番号(0始まり)
  func set(_ row: Int) {
    if row < 0 || row > list.count {
      return
    }
    
    let i = NSIndexSet(index: row) as IndexSet
    tbList.selectRowIndexes(i,byExtendingSelection: false)
  }

  /// 指定されたオブジェクトに一致する行にカーソルを設定する
  /// - Parameter entity: 設定するオブジェクト
  func set(_ entity: EntityObject) {
    
    if list.count < 0 {
      return
    }
    
    list.enumerated().forEach({
      row,en in
      
      if entity.url != en.url {
        return
      }
      
      set(row)
    })
  }

  /// カーソルがある行の番号を取得する
  /// - Returns: 行番号
  func get() -> Int? {
    if list.count < 0 {
      return nil
    }
    OSLog.mfx.info("selectedRow  \(self.tbList.selectedRow)")
    return tbList.selectedRow
  }
  
  /// カーソルがある行のオブジェクトを取得する
  /// - Returns: オブジェクト
  func get() -> EntityObject? {
    
    let o = list
    
    if o.count < 1 {
      return nil
    }
    
    guard let row: Int = get() else {
      return nil
    }

    return o[row]
  }
  
  func down() {
    set(tbList.selectedRow + 1)
  }

  func up() {
    set(tbList.selectedRow - 1)
  }
}

protocol ViewObjectApiCursor {
  func set(_ row: Int)
  func set(_ entity: EntityObject)
  func get() -> Int?
  func get() -> EntityObject?
  func down()
  func up()
}

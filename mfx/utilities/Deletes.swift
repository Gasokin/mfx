//
//  Deletes.swift
//  mfx
//
//  Created by 平賀義紀 on 2021/11/23.
//

import Foundation

class Deletes {
  
  static let fmgr = FileManager.default
  
  /// オブジェクトを直接削除する
  /// - Parameter url: 削除したいオブジェクト
  /// - Returns: 成功か失敗を表すタプル
  static func removeDirect(_ url: URL) -> (Bool,String) {
    
    let r = Result {try fmgr.removeItem(at: url)}
    switch r {
      case .success(let value):
        return (true,"削除成功。 \(value)")
      case .failure(let error):
        return (true,"削除失敗。 \(error)")
    }
  }
  
  
  ///オブジェクトをゴミ箱に移動する
  /// - Parameter url: 対象のURL
  /// - Returns: 成功か失敗を表すタプル
  static func removeTrash(_ url: URL) -> (Bool,String) {
    
    let r = Result {try fmgr.trashItem(at: url, resultingItemURL: nil)}
    switch r {
      case .success(let value):
        return (true,"削除成功。 \(value)")
      case .failure(let error):
        return (true,"削除失敗。 \(error)")
    }
  }
  
}

//
//  Sorts.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/03/27.
//

import Foundation

class Sorts {
  
  /// ファイル日付でソートを行う
  /// - Parameters:
  ///   - order: 昇順／降順
  /// - Returns: ソート用のクロージャ
  static func byDate(_ order: Consts.SortOrder) -> ((EntityObject,EntityObject) -> Bool) {
    let closure : ((EntityObject,EntityObject) -> Bool) =
    {(src,dst) -> Bool in
      if src.type == dst.type {
        var result = src.date < dst.date
        if order == .Dsc {
          result.toggle()
        }
        return result
      }
      
      return src.type.rawValue < dst.type.rawValue
    }
    return closure
  }
  
  /// ファイルサイズでソートを行う
  /// - Parameters:
  ///   - order: 昇順／降順
  /// - Returns: ソート用のクロージャ
  static func bySize(_ order: Consts.SortOrder) -> ((EntityObject,EntityObject) -> Bool) {
    let closure : ((EntityObject,EntityObject) -> Bool) =
    {(src,dst) -> Bool in
      if src.type == dst.type {
        
        // ディレクトリはサイズがないので名前でソートする
        if src.type == .D {
          var result = src.name < dst.name
          if order == .Dsc {
            result.toggle()
          }
          return result
        }
        
        var result = src.size < dst.size
        if order == .Dsc {
          result.toggle()
        }
        return result
      }
      
      return src.type.rawValue < dst.type.rawValue
    }
    return closure
  }
  
  /// ファイル名でソートを行う
  /// - Parameters:
  ///   - order: 昇順／降順
  /// - Returns: ソート用のクロージャ
  static func byName(_ order: Consts.SortOrder) -> ((EntityObject,EntityObject) -> Bool) {
    let closure : ((EntityObject,EntityObject) -> Bool) =
    {(src,dst) -> Bool in
      if src.type == dst.type {
        var result = src.name.lowercased() < dst.name.lowercased()
        if order == .Dsc {
          result.toggle()
        }
        return result
      }
      
      return src.type.rawValue < dst.type.rawValue
    }
    return closure
  }

  /// 拡張子でソートを行う
  /// - Parameters:
  ///   - order: 昇順／降順
  /// - Returns: ソート用のクロージャ
  static func byExt(_ order: Consts.SortOrder) -> ((EntityObject,EntityObject) -> Bool) {
    let closure : ((EntityObject,EntityObject) -> Bool) = {(src,dst) -> Bool in
      
      let ext_src = src.ext.lowercased()
      let ext_dst = dst.ext.lowercased()
      if ext_src == ext_dst {
        var result = src.name < dst.name
        if order == .Dsc {
          result.toggle()
        }
        return result
      }

      var result = ext_src < ext_dst
      if order == .Dsc {
        result.toggle()
      }
      return result
    }
    return closure
  }

  /// コピー用にソートを行う
  /// - Parameters:
  ///   - order: 昇順／降順
  /// - Returns: ソート用のクロージャ
  static func byCopy(_ order: Consts.SortOrder) -> ((EntityObject,EntityObject) -> Bool) {
    let closure : ((EntityObject,EntityObject) -> Bool) =
    {(src,dst) -> Bool in
      if src.type == dst.type {
        var result = src.name.lowercased() < dst.name.lowercased()
        if order == .Dsc {
          result.toggle()
        }
        return result
      }
      
      return src.type.rawValue > dst.type.rawValue
    }
    return closure
  }
}

//
//  Copies.swift
//  mfx
//
//  Created by 平賀義紀 on 2021/11/03.
//

import Foundation

/// ファイルコピーに関するルーチンを集めたクラス
class Copies {
  
  let fmgr = FileManager.default
  var _isCansel = false
  
  var isCansel: Bool {
    get {return _isCansel}
    set(value) {
      _isCansel = value
    }
  }

  /// 独自ルーチンを使用してファイルをコピーする
  /// - Parameters:
  ///   - src: コピー元ファイル
  ///   - dst: コピー先ファイル
  /// - Returns: true: 成功,false:失敗
  func mfx(src: EntityObject,dst: URL,ow: () -> Bool,pr: () -> Void) -> (Bool,String) {

    if !fmgr.fileExists(atPath: src.url.path) {
      return (false,"コピー元ファイルが存在しません \(src.url.path)")
    }
    
    // ファイルの場合はコピーして終わり
    if src.type == .F {
      return cpFile(src: src.url, dst: dst,ow: ow,pr: pr)
    }
    
    if src.type != .D {
      return (false,"ディレクトリ以外です \(src.url.path)")
    }
    
    // ディレクトリの場合は再帰しながらコピーする
    return cpDir(src: src.url, dst: dst,ow: ow,pr: pr)
  }

  /// ファイルのコピーを行う
  /// - Parameters:
  ///   - src: コピー元ファイル
  ///   - dst: コピー先ファイル
  /// - Returns: true: 成功,false:失敗
  private func cpFile(src: URL,dst: URL,ow: () -> Bool,pr: () -> Void) -> (Bool,String) {

    if fmgr.fileExists(atPath: src.path),!ow() {
      return (false,"上書きしません")
    }
    
    guard let src_res = Objects.getResource(src) else {
      return (false,"複写失敗： コピー元の情報が取得できませんでした。\(src.path)")
    }

    guard let size = src_res.fileSize else {
      return (false,"複写失敗： コピー元のファイルサイズが取得できませんでした。\(src.path)")
    }

    guard let istream = InputStream(url: src) else {
      return (false,"複写失敗： iStreamの作成に失敗しました。\(src.path)")
    }

    guard let ostream = OutputStream(url: dst,append: false) else {
      return (false,"複写失敗： oStreamの作成に失敗しました。\(dst.path)")
    }
    
    // コピー本体
    var size_total = 0
    var buffer = [UInt8](repeating: 0, count: getBufferSize(size: size))
    istream.open()
    ostream.open()
    while istream.hasBytesAvailable {
      let size = istream.read(&buffer, maxLength: buffer.capacity)
      size_total += size
      if size > 0 {
        ostream.write(&buffer, maxLength: size)
        pr()
      }
      
      if self._isCansel {
        break
      }
    }
    
    istream.close()
    ostream.close()
    
    if self._isCansel {
      // 取消しされた時はファイルを消す
      return Deletes.removeDirect(dst)
    }
    
    // 属性を設定する
    var d = dst
    let r = cpResource(src, &d)
    if !r.0 {
      return r
    }
    return (true,"複写成功。\(src.path) -> \(dst.path)")
  }
  
  /// ディレクトリのコピーを行う
  /// - Parameters:
  ///   - src: コピー元ディレクトリ
  ///   - dst: コピー先ディレクトリ
  /// - Returns: true: 成功,false:失敗
  private func cpDir(src: URL,dst: URL,ow: () -> Bool,pr: () -> Void) -> (Bool,String) {

    if fmgr.fileExists(atPath: dst.path),!ow() {
      return (false,"上書きしません")
    }
    
    // まずはディレクトリを作成する
    var to = dst.appendingPathComponent(src.lastPathComponent)
    do {
      try fmgr.createDirectory(at: to, withIntermediateDirectories: false, attributes: nil)
    } catch let error {
      return (false,"ディレクトリの作成に失敗しました。\(to.path)  \(error.localizedDescription)")
    }
    
    // 属性をコピーする
    let r = cpResource(src, &to)
    if !r.0 {
      return r
    }
    
    // ディレクトリに含まれるファイルをコピーする
    /*
    Objects2.getSubObjet(src).forEach() {
      let r = cpFile(src: $0, dst: to.appendingPathComponent($0.lastPathComponent), ow: ow, pr: pr)
      if !r.0 {
        pr()
      }
    }
    */

    return (true,"複写成功。\(src.path) -> \(dst.path)")
  }
  
  /// リソースをコピーする
  /// - Parameters:
  ///   - src: コピー元オブジェクト
  ///   - dst: コピー先オブジェクト
  /// - Returns: 成功、失敗を表すタプル
  private func cpResource(_ src: URL,_ dst: inout URL) -> (Bool,String) {
    
    guard let src_res = Objects.getResource(src) else {
      return (false,"リソースの取得に失敗しました。\(src.path)")
    }
    
    do {
      var r = URLResourceValues()
      r.contentModificationDate = src_res.contentModificationDate
      r.creationDate = src_res.creationDate
      r.contentAccessDate = src_res.contentAccessDate
      try dst.setResourceValues(r)
    } catch let error {
      return (false,"リソースの設定に失敗しました。\(dst.path)  \(error.localizedDescription)")
    }
    
    return (true,"リソースのコピーに成功しました。 \(dst.path)")
  }
  
  /// ファイルサイズごとに一度に読むバッファサイズを取得する
  /// - Parameter size: 対象ファイルのサイズ
  /// - Returns: ファイルサイズに応じたバッファサイズ
  private func getBufferSize(size: Int) -> Int {
    switch size {
      case 0..<1_024:
        return size
      case 1_024..<(1_024 * 1_024):
        return 1024
      default:
        return 1024 * 1024
    }
  }
}

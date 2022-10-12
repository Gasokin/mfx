//
//  BookmarkManager.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/07/17.
//

import Foundation
import Cocoa
import os

class Bookmark {
  
  static let i = Bookmark()
  let FILE_BOOKMARK = "mfx.bookmarks"
  let OPT = FileManager.SearchPathDirectory.applicationSupportDirectory
  
  var bookmarks: [URL: Data] = Dictionary()
  
  /// ブックマーク情報を保存するファイル
  var fileBookmark: URL? {
    get {
      let fmgr = FileManager.default
      guard let u = fmgr.urls(for: OPT, in: .userDomainMask).last else {
        return nil
      }
      return u.appendingPathComponent(FILE_BOOKMARK)
    }
  }
  
  /// URLからブックマークを取得する
  /// - Parameter url: 対象のURL
  /// - Returns: URLとブックマークのタプル
  func getBookmarkData(url: URL) -> (URL,Data)? {
    if let data = try? url.bookmarkData(options: [.withSecurityScope], includingResourceValuesForKeys: nil, relativeTo: nil) {
      return (url,data)
    }
    return nil
  }

  /// ディレクトリがアクセス許可されているか確認する
  ///
  /// - Parameter url: 確認したいディレクトリ
  /// - Returns: 許可されている場合はURL、されていない場合はnil
  func isAllow(_ url: URL) -> URL? {
    
    if bookmarks[url] != nil {
      OSLog.mfx.info("isAllow  許可されているディレクトリです(\(url.path))")
      return url
    }

    for b in bookmarks {
      if url.path.hasPrefix(b.key.path) {
        OSLog.mfx.info("isAllow  許可ディレクトリの配下なので許可されています(\(url.path))")
        return url
      }
    }
    OSLog.mfx.info("isAllow  許可されていないディレクトリです(\(url.path))")
    return nil
  }
  
  /// URLをブックマークとして保存する
  ///
  /// - Parameter url: 保存するURL
  func save(for url: URL) {
    
    guard let u = fileBookmark else {
      OSLog.mfx.info("Bookmarkファイルの取得に失敗しました \(url.path)")
      return
    }
    
    guard let d = self.getBookmarkData(url: url) else {
      OSLog.mfx.info("Bookmark URLの取得に失敗しました \(url.path)")
      return
    }

    bookmarks[d.0] = d.1
    
    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: bookmarks, requiringSecureCoding: false)
      try data.write(to: u)
      OSLog.mfx.info("Bookmarkの保存に成功しました \(url.absoluteString)")
    } catch {
      OSLog.mfx.info("Bookmarkの保存に失敗しました \(url.absoluteString)")
    }
  }
  
  /// ブックマークを読み込む
  func load() {
    
    guard let url = self.fileBookmark else {
      return
    }

    if !self.fileExists(url) {
      OSLog.mfx.info("Bookmarkファイルが存在しません(\(url.absoluteString))")
      return
    }

    do {
      let fileData = try Data(contentsOf: url)
      bookmarks = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(fileData) as! [URL: Data]
      for b in bookmarks {
        self.restoreBookmark(key: b.key, value: b.value)
      }
    } catch {
      OSLog.mfx.info("Bookmarkファイルが読み込めません(\(error.localizedDescription))")
    }
  }
  
  /// アクセス許可を停止する
  func endBookmark() {
    for b in bookmarks {
      b.key.stopAccessingSecurityScopedResource()
    }
  }
  
  private func restoreBookmark(key: URL, value: Data) {

    var isStale = false
    
    guard let u = try? URL.init(resolvingBookmarkData: value, options: [.withSecurityScope], relativeTo: nil, bookmarkDataIsStale: &isStale) else {
      OSLog.mfx.info("restoreBookmark Error")
      return
    }

    if isStale {
      OSLog.mfx.info("\(key.path) is State")
      return
    }
    
    // ここで startAccessingSecurityScopedResource しておかないと再起動後にアクセスができなくなる
    if !u.startAccessingSecurityScopedResource() {
      OSLog.mfx.info("\(key.path) is not Access")
    }
  }

  private func fileExists(_ url: URL) -> Bool {
    var isDir = ObjCBool(false)
    return FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir)
  }
}


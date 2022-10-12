//
//  Environment.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/03/29.
//

import Foundation
import Cocoa
import os

/// アプリが動いているMacの情報を取得するクラス
/// シングルトン
class Mac {
  
  static let i = Mac()
  private init() {}
  
  /// Macの画面サイズに応じた画面サイズを取得する
  var sizeScreen: Consts.ScreenSize {
    get {
      guard let frame = NSScreen.main?.visibleFrame else {
        return .Unkown
      }

      let size = (frame.width,frame.height)
      let size_default: (CGFloat,CGFloat) = (1512,944)
      if size == size_default {
        return .Middle
      } else if size > size_default {
        return .Large
      } else if size < size_default {
        return .Small
      } else {
        return .Unkown
      }
    }
  }
  
  /// Macの画面サイズに応じたフォントサイズを取得する
  var sizeFont: CGFloat {
    get {
      switch sizeScreen {
        case .Large:
          return 18
        case .Small:
          return 14
        default:
          return 16
      }
    }
  }

  /// システムで定義されたプロポーショナルフォントを取得する
  var fontProp : NSFont {
    get {
      return NSFont.systemFont(ofSize: sizeFont, weight: .regular)
    }
  }
  
  /// システムで定義されたモノリシックフォントを取得する
  var fontMono : NSFont {
    get {
      return NSFont.monospacedSystemFont(ofSize: sizeFont, weight: .regular)
    }
  }
  
  func isSandbox(_ u: URL) -> Bool {
    guard let root = appRoot else {
      return false
    }
    
    if u.path == root.path {
      return false
    }
    
    return u.path.hasPrefix(root.path)
  }
  
  var appSupport: URL? {
    get {
      let urls = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
      return urls.last
    }
  }
  
  /// アプリのルートディレクトリを取得する
  var appRoot: URL? {
    return appHome?.deletingLastPathComponent()
  }

  /// アプリのドキュメントディレクトリを取得する
  var appDocs: URL? {
    get {
      return try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
  }
  
  /// アプリのホームディレクトリを取得する
  var appHome: URL? {
    get {
      return FileManager.default.homeDirectoryForCurrentUser //.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
  }
}

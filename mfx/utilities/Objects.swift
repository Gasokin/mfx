//
//  Objects2.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/09/04.
//

import Foundation
import Cocoa
import os

class Objects {

  static let fmgr = FileManager.default
  static let ws = NSWorkspace.shared

  /// 取得するファイル情報(ディレクトリ取得用)
  static let rKey: [URLResourceKey] = [.pathKey,.nameKey,.parentDirectoryURLKey,
                     .fileSizeKey,.attributeModificationDateKey,
                     .creationDateKey,.contentAccessDateKey,
                     .contentModificationDateKey,
                     .isDirectoryKey,.isRegularFileKey,.isAliasFileKey,
                     .isSymbolicLinkKey,.isApplicationKey,
                     .fileResourceIdentifierKey,
                     .volumeNameKey,.volumeURLKey,
                     .volumeTotalCapacityKey,.volumeAvailableCapacityKey]
  static let rSet = Set(rKey)

  /// オブジェクトの情報が格納されたリソースを取得する
  /// - Parameter url: 取得対象のオブジェクトを表すURL
  /// - Returns: リソースが格納されたURLResourceValue、取得できない場合はnil
  static func getResource(_ u: URL) -> URLResourceValues? {
    switch(Result {try u.resourceValues(forKeys: Objects.rSet)}) {
      case .success(let resource):
        return resource
      case .failure(let error):
        OSLog.mfx.info("makeEntity:getResourceができませんでした。\(error.localizedDescription)")
        return nil
    }
  }
  
  /// オブジェクトの種類を判定する
  /// - Parameter res: 調べたいオブジェクトのリソース情報
  /// - Returns: EnumTypeで表されるオブジェクトの種類
  static func getType(_ res: URLResourceValues) -> Consts.TypeObj {
    
    switch true {
      case Miscs.unwrap(res.isSymbolicLink):
        return .L
      case Miscs.unwrap(res.isAliasFile):
        return .A
      case Miscs.unwrap(res.isDirectory):
        return .D
      case Miscs.unwrap(res.isRegularFile):
        return .F
      default:
        return .U
    }
  }
  
  static func getType(_ url: URL) -> Consts.TypeObj {

    guard let res = Objects.getResource(url) else {
      return .U
    }
    
    return getType(res)

  }
  
  static func resolveLink(_ url: URL) -> URL? {
    
    let type = getType(url)
    if type == .D || type == .F || type == .U {
      return url
    }

    if type == .L {
      return url.resolvingSymlinksInPath()
    }

    /*
    guard let u = try? URL.init(resolvingBookmarkData: value, options: [.withSecurityScope], relativeTo: nil, bookmarkDataIsStale: &isStale) else {
      OSLog.mfx.info("restoreBookmark Error")
      return
    }
     */

    do {
      return try URL(resolvingAliasFileAt: url, options: [.withSecurityScope])
    } catch {
      OSLog.mfx.info("resolve error = \(error.localizedDescription)")
    }
    return nil
  }
  
  /// 画面に表示する日付の取得
  /// - Parameter resource: 取得対象のオブジェクト情報
  /// - Returns: 日付の文字列
  static func getDate(_ type: Consts.TypeObj,_ res: URLResourceValues) -> Date? {
    
    var date: Date? = nil
    switch type {
      case .D:
        date = res.creationDate ?? res.contentModificationDate
      case .L,.A,.F:
        date = res.contentModificationDate
      default:
        date = nil
    }
    return date
  }

  /// オブジェクトアイコンを取得する
  /// - Parameters:
  ///   - url: 取得対象のオブジェクト
  ///   - res: 取得対象のオブジェクト情報
  /// - Returns: オブジェクトアイコン
  static func getIcon(_ url: URL,_ res: URLResourceValues) -> NSImage {

    if !Miscs.unwrap(res.isDirectory) {
      let ext = url.pathExtension
      if ext.count > 0 {
        return Caches.icon.object(forKey: ext as AnyObject) ?? getIconPushCache(url,ext as AnyObject)
      }
    }

    return ws.icon(forFile: url.path)
  }
  
  /// オブジェクトアイコンを取得してキャッシュに追加する
  /// - Parameters:
  ///   - url: 取得対象のオブジェクト
  ///   - ext: 取得対象の拡張子
  /// - Returns: オブジェクトアイコン
  static func getIconPushCache(_ url: URL,_ ext: AnyObject) -> NSImage {
    let icon = ws.icon(forFile: url.path)
    Caches.icon.setObject(icon, forKey: ext)
    return icon
  }
  
  static func getInfoDir(_ entities: [EntityObject]) -> EntityInfoDir {
    
    var size: Int = 0
    var count: [Int] = Array(repeating: 0, count: 5)
    entities.forEach() {
      if $0.type == .F {
        size += $0.size
      }
      
      count[$0.type.rawValue] += 1
    }
    
    return EntityInfoDir(size,count)
  }
  
  static func getMarkDir(_ entities: [EntityObject]) -> EntityInfoDir {
    
    var size: Int = 0
    var count: [Int] = Array(repeating: 0, count: 5)
    entities.forEach() {
      
      if !$0.mark {
        return
      }
      
      if $0.type == .F {
        size += $0.size
      }
      
      count[$0.type.rawValue] += 1
    }
    
    return EntityInfoDir(size,count)
  }

  static func getSubObjet(_ u: URL) -> [EntityObject] {

    // ディレクトリ配下のオブジェクト一覧を取得する
    guard let content = FileManager.default.enumerator(at: u, includingPropertiesForKeys: rKey,options: .skipsSubdirectoryDescendants) else {
      return [EntityObject]()
    }

    var es = Array(repeating: [EntityObject](), count: 5)

    // ディレクトリに格納されているオブジェクトの一覧作成
    for case let u2 as URL in content {
      
      guard let res = self.getResource(u2) else {
        OSLog.mfx.info("リソースの取得に失敗しました \(u2.path)")
        continue;
      }
      
      let type = self.getType(res)
      let entity = EntityObject(u2,type)
      entity.date = self.getDate(type, res) ?? Consts.UNKOWN_DATE
      entity.size = res.fileSize ?? Consts.UNKOWN_SIZE
      entity.icon = getIcon(u2,res)
      entity.icon.resizingMode = .stretch
      entity.type_string = Consts.TYPE_STRING[type.rawValue]
      if type == .F {
        entity.name = u2.deletingPathExtension().lastPathComponent
        entity.ext = u2.pathExtension
      } else {
        entity.name = u2.lastPathComponent
        entity.ext = ""
      }

      es[type.rawValue].append(entity)
    }
    
    let objs_d = es[Consts.TYPE_D].sorted(by: Sorts.byName(.Asc))
    let objs_l = es[Consts.TYPE_L].sorted(by: Sorts.byName(.Asc))
    let objs_a = es[Consts.TYPE_A].sorted(by: Sorts.byName(.Asc))
    let objs_f = es[Consts.TYPE_F].sorted(by: Sorts.byName(.Asc))
    return objs_d + objs_l + objs_a + objs_f
  }
  
  @discardableResult
  static func execute(_ url: URL) -> String? {

    var message = "正常に完了しました"
    let workspace = NSWorkspace.shared
    
    guard let app = workspace.urlForApplication(toOpen: url) else {
      return "定義されたアプリケーションがないため、実行できません"
    }
    
    let configuration = NSWorkspace.OpenConfiguration()
    configuration.activates = false
    workspace.openApplication(at: url, configuration: configuration, completionHandler: {
      app,err in
      message =  "アプリ起動でエラーが発生しました。原因： \(err?.localizedDescription ?? "原因不明")"
    })

    OSLog.mfx.info("Objects.execute End")
    return message
  }
  
}

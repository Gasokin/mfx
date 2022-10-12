//
//  ViewControllerApi.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/06/09.
//

import Foundation
import Cocoa
import os

extension VcMain: VcMainAPI {
  
  var viewActive: ViewObject {
    get {return viewA}
  }

  var viewDeActive: ViewObject {
    get {return viewD}
  }

  /// メッセージビューにメッセージを追加する
  var message: String {
    get { txMessage.string }
    set {
      txMessage.string = newValue + "\n" + txMessage.string
    }
  }
  
  func setDetail() {
    
    guard let entity: EntityObject = viewA.get() else {
      return
    }
    
    setDetail(entity)
  }
  
  func setDetail(_ entity: EntityObject?) {

    guard let en = entity else {
      lbDetailName.stringValue = ""
      lbDetailInfo.stringValue = ""
      return
    }
    
    let unit = Units(en.size)
    let info = "\(unit.BF)  \(Dates.toString(en.date,"yyyy-MM-dd HH:mm:ss"))"
    lbDetailName.stringValue = en.url.lastPathComponent.description
    lbDetailInfo.stringValue = info
  }
  
  /// アクセス許可用のフォルダ選択画面を開く
  /// - Parameter u: 許可したいURL
  /// - Returns: true: 許可、false: 不許可
  func dispOpenPanel(_ u: URL) -> URL? {
    let op = NSOpenPanel()
    op.allowsMultipleSelection = false
    op.canChooseDirectories = true
    op.canCreateDirectories = true
    op.canChooseFiles = false
    op.directoryURL = u
    if op.runModal() == .OK {
      Bookmark.i.save(for: op.url!)
      return op.url
    }
    
    return nil
  }
  
  func setObjectMask(_ value: String) {
    viewA.object.setObjectMask(value)
  }
  
  
  /// ファイルを削除する
  func remove() {

    OSLog.mfx.info("delete start")

    // ディレクトリ監視を一時停止
    viewA.removeFilePresenter()
    
    let marks = viewA.marks
    if marks.count > 0 {
      marks.forEach() {
        let r = Deletes.removeTrash($0.url)
        if r.0 {
          message = "削除： \($0.url.path)"
        } else {
          let mes = "削除に失敗しました(\(r.1)  \($0.url.path)"
          OSLog.mfx.error("\(mes)")
          message = mes
        }
      }
    } else {
      if let entity: EntityObject = viewA.cursor.get() {
        let r = Deletes.removeTrash(entity.url)
        if r.0 {
          message = "削除： \(entity.url.path)"
        } else {
          let mes = "削除に失敗しました(\(r.1)  \(entity.url.path)"
          OSLog.mfx.error("\(mes)")
          message = mes
        }
      }
    }

    // ディレクトリ監視を再開
    viewA.addFilePresenter()

    OSLog.mfx.info("delete end")
  }
  
  /// ファイルのコピーを行う
  func copy() {
    
    OSLog.mfx.info("copy start")

    // ディレクトリ監視を一時停止
    viewA.removeFilePresenter()
    
    // マークされているオブジェクトがあればそれが対象
    // なければカーソル行のオブジェクトが対象
    var src_objects: [EntityObject] = viewA.marks
    if src_objects.count < 1 {
      src_objects.removeAll()
      if let src: EntityObject = viewA.cursor.get() {
        src_objects.append(src)
      }
    }
    
    // どちらもなければ終了
    if src_objects.count < 1 {
      let mes = "コピー対象のオブジェクトがありません"
      OSLog.mfx.info("\(mes)")
      message = mes
      return
    }
    
    // コピー先のディレクトリ
    guard let dst_dir = viewD.url else {
      let mes = "コピー先のディレクトリが取得できませんでした"
      OSLog.mfx.info("\(mes)")
      message = mes
      return
    }
    
    let fmgr = FileManager.default
    
    // 一件づつ処理
    src_objects.forEach() {
      
      let src = $0.url
      
      // コピー元の存在検査
      if !fmgr.fileExists(atPath: src.absoluteString) {
        let mes = "コピー元のオブジェクトが存在しません"
        OSLog.mfx.info("\(mes)")
        message = mes
        return
      }
      
      // コピー先オブジェクトの作成
      let dst = dst_dir.appendingPathComponent(src.lastPathComponent)
      
      // コピー先オブジェクトが存在する場合は対応を問い合わせる
      if fmgr.fileExists(atPath: dst.absoluteString) {
        
      }
    }

    // ディレクトリ監視を再開
    viewA.addFilePresenter()

    OSLog.mfx.info("copy end")
  }
}

//
//  ViewControllerSegue.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/08/07.
//

import Foundation
import Cocoa
import os

extension VcMain {

  /// 各子画面に渡すパラメータを設定する
  /// - Parameters:
  ///   - segue: 遷移先の画面
  ///   - sender: その他情報
  override func prepare(for segue: NSStoryboardSegue, sender: Any?) {

    let frame = vwRoot.frame

    // ビューア画面
    if let vc = segue.destinationController as? VcViewer {
      vc.size = NSSize(width: frame.width * 0.8, height: frame.height * 0.95)
      if let u = viewA.cursor.get()?.url {
        vc.url = u
      }
    }

    // コピー／移動画面
    if let vc = segue.destinationController as? VcProgress {
      vc.size = NSSize(width: frame.width * 0.8, height: frame.height * 0.4)
      if let entity = sender as? EntityCopy {
        vc.entity = entity
      }
    }

    // 一行入力画面
    if let vc = segue.destinationController as? VcInput {
      vc.size = NSSize(width: frame.width * 0.3, height: frame.height * 0.4)
      if let entity = sender as? EntityInput {
        vc.subject = entity.subject
        vc.comment = entity.comment
        vc.success = entity.success
      }
    }
  }

  /// ビューア画面に遷移する
  func segueViewer() {
    self.performSegue(withIdentifier: "segueViewer", sender: nil)
  }
  
  /// コピー移動画面に遷移する
  func segueProgress(_ progress: Consts.Progress) {
    
    let entities = viewA.markOrCursor
    if entities.count < 1 {
      let mes = "対象のオブジェクトが選択されていません"
      OSLog.mfx.info("\(mes)")
      message = mes
      return
    }
    
    let entity = EntityCopy()
    entity.progress = progress
    entity.subject = Consts.PROGRESS_SUBJECT[progress.rawValue]
    entity.comment = Consts.PROGRESS_COMMENT[progress.rawValue]
    entity.src = entities
    entity.dst = viewD.url

    self.performSegue(withIdentifier: "segueProgress", sender: entity)
  }

  /// 一行入力画面に遷移する
  func segueInput(_ subject: String,_ comment: String,_ success: @escaping (String) -> ()) {
    let entity = EntityInput()
    entity.subject = subject
    entity.comment = comment
    entity.success = success
    self.performSegue(withIdentifier: "segueInput", sender: entity)
  }
}

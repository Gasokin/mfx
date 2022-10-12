//
//  VCViewer.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/08/06.
//

import Cocoa
import os

class VcViewer: ViewController {
  
  @IBOutlet var vwRoot: NSVisualEffectView!
  @IBOutlet var txViewer: NSTextField!
  @IBOutlet weak var lbFilename: NSTextField!

  var url: URL!
  
  /// 起動時の画面のレイアウト調整を行う
  override func setView() {
    
    super.setView()

    OSLog.mfx.info("setView \(self.url.path)")
    do {
      let content = try String(contentsOf: url)
      txViewer.stringValue = content
    } catch {
      OSLog.mfx.info("ファイル読込エラー \(error.localizedDescription)")
      txViewer.stringValue = error.localizedDescription
    }
    
    lbFilename.stringValue = url.path
    txViewer.font = Mac.i.fontMono
    
  }
}

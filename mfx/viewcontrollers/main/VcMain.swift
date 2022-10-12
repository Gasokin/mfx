//
//  ViewController.swift
//  mfx
//
//  Created by 平賀義紀 on 2021/11/03.
//

import os
import Cocoa

class VcMain: NSViewController {
  
  @IBOutlet var vwRoot: NSView!
  @IBOutlet weak var vwMain: NSView!
  @IBOutlet weak var vwL: ViewObject!
  @IBOutlet weak var vwR: ViewObject!
  @IBOutlet weak var lbDetailName: NSTextField!
  @IBOutlet weak var lbDetailInfo: NSTextField!
  @IBOutlet weak var spHorizon: NSSplitView!
  @IBOutlet var txMessage: NSTextView!
  
  var viewA: ViewObject!
  var viewD: ViewObject!
  let cfg = Configs.i

  override func viewDidLoad() {
    super.viewDidLoad()

    cfg.load()
    Bookmark.i.load()

    setView()
    setList()
    
    lbDetailName.font = cfg.item.DetailName.Font.font
    lbDetailInfo.font = cfg.item.DetailInfo.Font.font
    txMessage.font = cfg.item.Message.Font.font

    /*
     let dst = EntityObject(URL(fileURLWithPath: "/Users/yoshinori/Desktop"))
     let cps = Copies()
     let r = cps.mfx(src: en,
     dst: dst,
     ow: {() -> Bool in
     self.lsbel.stringValue = "OverWrite?"
     return true
     },
     pr: {self.lsbel.stringValue = "Complete!"}
     )
     
     status.stringValue = r.0.description
     message.stringValue = r.1
    */
  }
  
  override func viewDidDisappear() {
    
    OSLog.mfx.info("viewDidDisappear: Start")

    // ディレクトリ監視を終了する
    viewA.removeFilePresenter()
    viewD.removeFilePresenter()
    
  }
  
  override var representedObject: Any? {
    didSet {
    }
  }
  
  /// 起動時の画面のレイアウト調整を行う
  func setView() {
    
    // 画面のサイズ調整
    // windowではなくviewの大きさを調整する
    guard let screen = NSScreen.main else {
      OSLog.mfx.info("viewDidLoad メインウィンドウの取得に失敗")
      return
    }
    let size = (Mac.i.sizeScreen == .Large) ? 0.5 : 0.7
    let w = screen.visibleFrame.width * size
    let h = screen.visibleFrame.height
    vwRoot.setFrameSize(NSSize(width: w,height: h))

    // メッセージビューの大きさは3行分くらい
    let sizeMessageRow :CGFloat = 3
    let viewMessageHeight = SettingVariable.i.Fonts.message.height * sizeMessageRow
    let viewDetailHeight = lbDetailName.frame.height + lbDetailInfo.frame.height + 8
    let position = vwMain.frame.height - viewDetailHeight - viewMessageHeight
    spHorizon.setPosition(position , ofDividerAt: 0)
  }
  
  /// リスト部の設定を行う
  func setList() {

    guard let dirDefault = Mac.i.appHome else {
      return
    }
    
    vwL.config = Configs.i.item.left
    vwR.config = Configs.i.item.right
    vwL._api_main = self
    vwR._api_main = self

    viewA = vwL
    viewD = vwR
    viewA.firstResponder = true
    viewD.firstResponder = false
    setDir(vwL,cfg.item.left.url ?? dirDefault)
    setDir(vwR,cfg.item.right.url ?? dirDefault)

    Status.i.active = .ListL
  }
}


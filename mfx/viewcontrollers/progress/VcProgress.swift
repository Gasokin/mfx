//
//  ViewControllerProgress.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/08/10.
//

import Cocoa
import os

class VcProgress: ViewController {
  
  @IBOutlet var txText: NSTextView!
  
  var entity: EntityCopy!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear() {
    super.viewDidAppear()
    
    switch entity.progress {
      case .COPY:
        cp()
      case .MOVE:
        mv()
      case .DELETE:
        rm()
      default:
        OSLog.mfx.info("種別が不明です。 \(self.entity.progress.rawValue)")
    }
  }
  
  func cp() {
    
    OSLog.mfx.info("複写開始：　\(self.entity.src.count)")

    OSLog.mfx.info("複写終了：　\(self.entity.src.count)")

  }
  
  func mv() {
    
  }
  
  func rm() {
    
  }
  
}

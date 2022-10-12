//
//  VCBase.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/08/07.
//

import Cocoa
import os

class ViewController: NSViewController {
  
  var size: NSSize!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setView()
  }
  
  override func keyUp(with event: NSEvent) {
    
    if event.keyCode.equals(Key.ESC,Key.Q) {
      self.dismiss(self)
      return
    }
    super.keyUp(with: event)
    
  }
  
  func setView() {
    self.view.setFrameSize(size)
  }
}

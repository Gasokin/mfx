//
//  VcInput.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/09/19.
//

import Cocoa
import os

class VcInput: ViewController,NSTextFieldDelegate {

  @IBOutlet weak var lbSubject: NSTextField!
  @IBOutlet weak var lbComment: NSTextField!
  @IBOutlet weak var txInput: NSTextField!
  
  var subject = ""
  var comment = ""
  var success: Optional<(String) -> ()> = nil

  override func viewDidLoad() {
    super.viewDidLoad()
    
    lbSubject.stringValue = subject
    lbComment.stringValue = comment
    
    txInput.delegate = self
  }
  
  func controlTextDidEndEditing(_ obj: Notification) {
    if let s = success {
      s(txInput.stringValue)
    }
    dismiss(self)
  }
}

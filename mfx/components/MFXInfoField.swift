//
//  MFXInfoField.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/05/08.
//

import Cocoa
import os

class MFXInfoField: NSTextField {
  
  let strNum = "999,999"
  let strSize = "9999,9ZZ"
  let lbUsed = "used"
  let lbDir = "dir"
  let lbFile = "file"
  let lbLink = "l/a"

  let m1: CGFloat = 3
  let m2: CGFloat = 10

  private var _size = 0
  private var _count = Array(repeating: 0, count: 4)
  
  @discardableResult
  func chain(_ closure: (Self) -> Void) -> Self {
    closure(self)
    return self
  }
  
  var size: Int {
    get {return _size}
    set {
      _size = newValue
      needsDisplay = true
    }
  }

  var count: [Int] {
    get {return _count}
    set {
      _count = newValue
      needsDisplay = true
    }
  }
  
  func reset() {
    _size = 0
    _count = Array(repeating: 0, count: 4)
  }
  
  func set(_ counts: [Int],_ size: Int) {
    _count = counts
    _size = size
    needsDisplay = true
  }

  private func calcWidth(_ tx: NSFont,_ lb: NSFont) -> (CGFloat,[CGFloat]) {

    let wNum = tx.width(strNum,kern: -1) // ファイル数は99万
    let wUse = tx.width(strSize,kern: -1) // サイズは999.0GB
    let wLU = lb.width(lbUsed,kern: -1)
    let wLD = lb.width(lbDir,kern: -1)
    let wLF = lb.width(lbFile,kern: -1)
    let wLL = lb.width(lbLink,kern: -1)
    return (wLU + wUse + wLD + wLF + wLL + (wNum * 3) + (m1 * 4) + (m2 * 3),
            [wNum,wUse,wLU,wLD,wLF,wLL])

  }
  
  /// 画面サイズに合わせて表示領域を調整する
  /// - Parameter dirtyRect: 画面の表示領域全体
  /// - Returns: 調整した結果の各項目のNSRect
  func calcLayout(_ dirtyRect: NSRect) -> (NSFont,NSFont,[NSRect]) {
    
    var fTx = Defs.font.infoTX
    var fLb = Defs.font.infoLB
    var w = calcWidth(fTx,fLb)
    while (w.0 > dirtyRect.width) {
      fTx = fTx.minus()
      fLb = fLb.minus()
      
      w = calcWidth(fTx,fLb)
    }
    
    let xUse: CGFloat = (dirtyRect.width - w.0) / 2
    let xLU: CGFloat = xUse + w.1[1] + m1
    let xD: CGFloat = xLU + w.1[2] + m2
    let xLD: CGFloat = xD + w.1[0] + m1
    let xF: CGFloat = xLD + w.1[3] + m2
    let xLF: CGFloat = xF + w.1[0] + m1
    let xL: CGFloat = xLF + w.1[4] + m2
    let xLL: CGFloat = xL + w.1[0] + m1

    // flb1は -1 すると下限が合う
    let yTx: CGFloat = dirtyRect.height - fTx.height
    let yLb: CGFloat = dirtyRect.height - fLb.height - 1

    let nLU = NSRect(x: xLU, y: yLb, width: w.1[2], height: dirtyRect.height)
    let nUse = NSRect(x: xUse, y: yTx, width: w.1[1], height: dirtyRect.height)
    let nLD = NSRect(x: xLD , y: yLb, width: w.1[3], height: dirtyRect.height)
    let nD = NSRect(x: xD, y: yTx, width: w.1[0], height: dirtyRect.height)
    let nLF = NSRect(x:xLF , y: yLb, width: w.1[4], height: dirtyRect.height)
    let nF = NSRect(x: xF, y: yTx, width: w.1[0], height: dirtyRect.height)
    let nLL = NSRect(x: xLL, y: yLb, width: w.1[5], height: dirtyRect.height)
    let nL = NSRect(x: xL, y: yTx, width: w.1[0], height: dirtyRect.height)
    
    return (fTx,fLb,[nLU,nUse,nLD,nD,nLF,nF,nLL,nL])
  }

  override func draw(_ dirtyRect: NSRect) {
    
    if dirtyRect.width < 40 {
      print("draw limit \(dirtyRect.width)")
      return
    }
    
    let rects = calcLayout(dirtyRect)
    let fmtTx = DisplayFormatter(rects.0)
    let fmtLb = DisplayFormatter(rects.1)
    fmtTx.right(Units(_size).Auto,kern: -1).draw(in: rects.2[1])
    fmtLb.center(lbUsed,kern: -1).draw(in: rects.2[0])
    fmtTx.right(Nums.toString(_count[0]),kern: -1).draw(in: rects.2[3])
    fmtLb.center(lbDir,kern: -1).draw(in: rects.2[2])
    fmtTx.right(Nums.toString(_count[1]),kern: -1).draw(in: rects.2[5])
    fmtLb.center(lbFile,kern: -1).draw(in: rects.2[4])
    fmtTx.right(Nums.toString(_count[2] + _count[3]),kern: -1).draw(in: rects.2[7])
    fmtLb.center(lbLink,kern: -1).draw(in: rects.2[6])
  }
  
}

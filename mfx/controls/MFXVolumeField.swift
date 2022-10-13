//
//  MFXVolumeField.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/07/26.
//

import Cocoa

class MFXVolumeField: NSTextField {
  
  private var _name = ""
  private var _total = 0
  private var _use = 0
  private var _free = 0
  
  func set(_ v: EntityVolume) {
    self._name = v.name
    self._total = v.size_t
    self._use = v.size_u
    self._free = v.size_f
    self.needsDisplay = true
  }
  
  override func draw(_ dirtyRect: NSRect) {
    //super.draw(dirtyRect)
    
    let fnt = self.font ?? Mac.i.fontMono

    let name = _name
    let capa = "全：\(Units(_total).Auto)  空：\(Units(_free).Auto)"
    
    let wName = name.widthOfString(usingFont: fnt)
    let wCapa = capa.widthOfString(usingFont: fnt)

    let xName: CGFloat = 0
    let xCapa: CGFloat = dirtyRect.width - wCapa - 10

    let rName = NSRect(x: xName, y: 0, width: wName, height: dirtyRect.height)
    let rCapa = NSRect(x: xCapa, y: 0, width: wCapa, height: dirtyRect.height)

    let fmt = DisplayFormatter(fnt)
    fmt.left(name).draw(in: rName)
    fmt.right(capa).draw(in: rCapa)
  }
  
}

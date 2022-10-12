//
//  TableViewCell.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/08/30.
//

import Cocoa
import os

class TableViewCell: NSTextField {
  
  let MARGIN_S: CGFloat = 3
  let MARGIN_M: CGFloat = 5
  let MARGIN_L: CGFloat = 10

  var entity: EntityObject? = nil

  override func draw(_ dirtyRect: NSRect) {

    guard let en = entity else {
      return
    }
    
    compact(dirtyRect,en)
    Configs.i.draw.width = dirtyRect.width
  }
  
  /// 簡易表示
  /// - Parameters:
  ///   - dirtyRect: 描画領域
  ///   - entity: 描画オブジェクト
  func compact(_ dirtyRect: NSRect,_ entity: EntityObject) {
    
    if entity.type == .F {
      compact_file(dirtyRect,entity)
    } else {
      compact_dir(dirtyRect,entity)
    }
  }
  
  private func compact_dir(_ dirtyRect: NSRect,_ entity: EntityObject) {

    let f = self.font ?? Mac.i.fontMono
    let draw = Configs.i.draw
    var dir = draw.dir

    // カラムの大きさが変わったら再計算
//    if draw.width == 0 || draw.width != dirtyRect.width || dir.w.icon == 0 {
      let y = (dirtyRect.height - f.height) / 2

      dir.w.icon = dirtyRect.height - 2
      dir.w.size = f.width("<UNKOWN>",kern: -1)
      dir.w.date = f.width("99-99",kern: -1)
      dir.w.name = dirtyRect.width - (dir.w.icon + dir.w.size + dir.w.date) - (MARGIN_L * 2) - (MARGIN_S * 1)
      
      dir.x.icon = 0.0
      dir.x.name = dir.x.icon + dir.w.icon + MARGIN_S
      dir.x.size = dir.x.name + dir.w.name + MARGIN_L
      dir.x.date = dir.x.size + dir.w.size + MARGIN_L
      
      dir.r.icon = NSRect(x: dir.x.icon,y: 0,width: dir.w.icon,height: dir.w.icon)
      dir.r.name = NSRect(x: dir.x.name,y: y,width: dir.w.name,height: dirtyRect.height)
      dir.r.size = NSRect(x: dir.x.size,y: y,width: dir.w.size,height: dirtyRect.height)
      dir.r.date = NSRect(x: dir.x.date,y: y,width: dir.w.date,height: dirtyRect.height)
      
      Configs.i.draw.dir = dir
//    }

    let fmt = DisplayFormatter(f)
    entity.icon.size = NSSize(width: dir.w.icon, height: dir.w.icon)
    entity.icon.draw(in: dir.r.icon)
    fmt.right(entity.type_string,kern: -1).draw(in: dir.r.size)
    fmt.right(Dates.toList(entity.date),kern: -1).draw(in: dir.r.date)
    fmt.left(entity.name,kern: 0,.byTruncatingTail).draw(in: dir.r.name)
  }
  
  private func compact_file(_ dirtyRect: NSRect,_ entity: EntityObject) {

    let f = self.font ?? Mac.i.fontMono
    let draw = Configs.i.draw
    var file = draw.file

    // カラムの大きさが変わったら再計算
//    if draw.width == 0 || draw.width != dirtyRect.width || file.w.icon == 0 {
      let y = (dirtyRect.height - f.height) / 2

      file.w.icon = dirtyRect.height - 2
      file.w.size = f.width("<UNKOWN>",kern: -1)
      file.w.date = f.width("99-99",kern: -1)
      file.w.ext = f.width("XXXXX",kern: -1)
      file.w.name = dirtyRect.width - (file.w.icon + file.w.size + file.w.date + file.w.ext) - (MARGIN_L * 3) - (MARGIN_S * 1)
      
      file.x.icon = 0.0
      file.x.name = file.x.icon + file.w.icon + MARGIN_S
      file.x.ext = file.x.name + file.w.name + MARGIN_L
      file.x.size = file.x.ext + file.w.ext + MARGIN_L
      file.x.date = file.x.size + file.w.size + MARGIN_L
      
      file.r.icon = NSRect(x: file.x.icon,y: 0,width: file.w.icon,height: file.w.icon)
      file.r.name = NSRect(x: file.x.name,y: y,width: file.w.name,height: dirtyRect.height)
      file.r.ext = NSRect(x: file.x.ext,y: y,width: file.w.ext,height: dirtyRect.height)
      file.r.size = NSRect(x: file.x.size,y: y,width: file.w.size,height: dirtyRect.height)
      file.r.date = NSRect(x: file.x.date,y: y,width: file.w.date,height: dirtyRect.height)
      
      Configs.i.draw.file = file
//    }

    let fmt = DisplayFormatter(f)
    entity.icon.size = NSSize(width: file.w.icon, height: file.w.icon)
    entity.icon.draw(in: file.r.icon)
    fmt.right(Units(entity.size).Auto,kern: -1).draw(in: file.r.size)
    fmt.right(Dates.toList(entity.date),kern: -1).draw(in: file.r.date)
    fmt.left(entity.name,kern: 0,.byTruncatingTail).draw(in: file.r.name)
    fmt.left(entity.ext,kern: -1,.byTruncatingTail).draw(in: file.r.ext)
  }
}

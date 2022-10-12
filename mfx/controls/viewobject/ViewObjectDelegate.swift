//
//  ViewObjectDelegate.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/08/31.
//

import Foundation
import Cocoa
import os

extension ViewObject: NSTableViewDelegate {
  
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

    let id = NSUserInterfaceItemIdentifier(rawValue: "CellView")
    guard let r = tableView.makeView(withIdentifier: id, owner: self) as? NSTableCellView else {
      return nil
    }

    if let t = r.textField as? TableViewCell {
      t.entity = _filter_now ? _list_filter[row] : _list[row]
      t.font = tableView.font ?? Mac.i.fontMono
      let h = (t.font?.height ?? Mac.i.fontMono.height) + 2
      t.setFrameSize(NSSize(width: t.frame.width, height: h))
    }

    if let rv = tableView.rowView(atRow: row, makeIfNecessary: false) as? TableRowView {
      let o = _filter_now ? _list_filter[row] : _list[row]
      rv.backgroundColor = o.mark ? NSColor.lightGray : NSColor.clear
      rv.firstResponder = _responder
    }
    
    return r
  }
  
  func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
    return tableView.rowView(atRow: row, makeIfNecessary: false) as? TableRowView ?? TableRowView()
  }
  
  func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
    return (tableView.font?.height ?? Mac.i.fontMono.height) + 2
  }
}

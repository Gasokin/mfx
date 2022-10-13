//
//  ViewObjectApiObject.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/09/18.
//

import Foundation
import Cocoa
import os

extension ViewObject: ViewObjectApiObject {
  
  var marks: [EntityObject] {
    get {
      return list.filter() {
        return $0.mark
      }
    }
  }
  
  var markOrCursor: [EntityObject] {
    get {
      let marks = marks
      if marks.count > 0 {
        return marks
      }
      
      var entities = [EntityObject]()
      guard let entity: EntityObject = get() else {
        return entities
      }
      entities.append(entity)
      return entities
    }
  }
  
  func toggleMark() {
    
    guard let entity: EntityObject = cursor.get() else {
      return
    }
    
    entity.mark.toggle()

    // 選択行だけ書き直す
    let r = NSIndexSet(index: tbList.selectedRow) as IndexSet
    let c = NSIndexSet(index: 0) as IndexSet
    tbList.reloadData(forRowIndexes: r, columnIndexes: c)

    let mark = Objects.getMarkDir(list)
    lbInfoMark.stringValue = mark.toString()
  }

  func setObjectMask(_ value: String) {

    guard let u = _current_url else {
      return
    }

    if value.count < 1 {
      _filter_string = nil
      _list_filter.removeAll()
      tbList.reloadData()
      lbDir.stringValue = "\(u.path)/"
      return
    }
    
    _list_filter = [EntityObject]()
    value.split(separator: " ").forEach() {
      let v = String($0)
      guard let reg = try? NSRegularExpression(pattern: v,options: [.caseInsensitive,] ) else {
        lbDir.stringValue = u.path
        return
      }

      let temp_filter = _list.filter() {
        
        if $0.type != .F {
          return true
        }
        
        let n = $0.url.lastPathComponent
        let r = reg.matches(in: n, range: NSRange(location: 0, length: n.count))
        return r.count > 0
      }
      
      _list_filter += temp_filter
    }

    _filter_now = true
    _filter_string = value
    reloadData(u)
    lbDir.stringValue = "\(u.path)/[\(_filter_string)]"
  }

}

protocol ViewObjectApiObject {
  
  var marks: [EntityObject] {get}
  
  var markOrCursor: [EntityObject] {get}
  
  func toggleMark()
  
  func setObjectMask(_ value: String)
  
}

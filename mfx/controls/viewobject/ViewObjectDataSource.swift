//
//  ViewObjectDataSource.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/08/31.
//

import Foundation
import Cocoa
import os

extension ViewObject: NSTableViewDataSource {
  
  func numberOfRows(in tableView: NSTableView) -> Int {
    return _filter_now ? _list_filter.count : _list.count
  }
}

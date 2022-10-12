//
//  EURL.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/07/01.
//

import Foundation

extension URL {
  
  var pathDecode: String {
    get {return absoluteString.removingPercentEncoding ?? ""}
  }
  
}

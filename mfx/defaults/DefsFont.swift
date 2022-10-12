//
//  DefaultFont.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/06/05.
//

import Foundation
import Cocoa

class DefsFont {
  
  /// 既定のフォント
  let font = Mac.i.fontMono

  /// 左右リストのフォント
  let listL = Mac.i.fontMono
  let listR = Mac.i.fontMono

  /// メッセージのフォント
  let message = Mac.i.fontMono
  
  let detail1 = Mac.i.fontMono
  let detail2 = Mac.i.fontMono

  // ディレクトリ情報のラベルはテキストより小さくする
  let infoTX = Mac.i.fontMono
  let infoLB = Mac.i.fontMono.new(Mac.i.sizeFont - 3)

}

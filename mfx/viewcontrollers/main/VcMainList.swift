//
//  ViewControllerList.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/04/02.
//

import Foundation
import Cocoa
import os

extension VcMain {
  
  func executeObject() {
    
    guard let e1: EntityObject = viewA.cursor.get() else {
      return
    }
    
    guard let u = Objects.resolveLink(e1.url) else {
      OSLog.mfx.info("executeObject = \(e1.url.path) is null")
      return
    }
    let type = Objects.getType(u)
    
    OSLog.mfx.info("executeObject = \(e1.url.path) -> \(u.path)  type = \(type.rawValue)")

    switch type {
      case .D,.A:
        setDir()
      case .F:
        if let m = Objects.execute(u) {
          message = m
        }
      default:
        self.message = "不明なファイル種類です。\(u.path)  \(type)"
    }
  }
  
  func setDir() {
    
    guard let u = viewA.cursor.get()?.url else {
      return
    }
    
    setDir(viewA,u)
  }
  
  func setDir(_ view: ViewObject,_ url: URL) {

    // サンドボックス内ならそのまま移動
    if Mac.i.isSandbox(url) {
      OSLog.mfx.info("サンドボックス内です \(url.path)")
      DispatchQueue.main.async {
        view.setDir(url)
      }
      saveConfig(view, url)
      return
    }
    
    // Sandbox外のディレクトリの場合はNSOpenPanelで許可させる
    if let u2 = Bookmark.i.isAllow(url) {
      OSLog.mfx.info("許可ディレクトリです \(u2.path)")
      DispatchQueue.main.async {
        view.setDir(u2)
      }
      saveConfig(view, url)
      return
    }
    
    guard let u3 = dispOpenPanel(url) else {
      OSLog.mfx.info("アクセスが許可されませんでした。\(url.path)")
      return
    }
    
    DispatchQueue.main.async {
      if let m = view.setDir(u3) {
        self.message = m
      }
    }
    saveConfig(view, url)
  }
  
  func saveConfig(_ view: ViewObject,_ url: URL) {
    if view == vwL {
      Configs.i.item.left.url = url
    } else {
      Configs.i.item.right.url = url
    }
    Configs.i.save()
  }

}

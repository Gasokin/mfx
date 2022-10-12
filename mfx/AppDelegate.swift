//
//  AppDelegate.swift
//  mfx
//
//  Created by 平賀義紀 on 2021/11/03.
//

import Cocoa
import os

@main
class AppDelegate: NSObject, NSApplicationDelegate {

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Insert code here to initialize your application
  }
  
  func applicationWillTerminate(_ aNotification: Notification) {
    OSLog.mfx.info("アプリケーションを終了します")
    Bookmark.i.endBookmark()
  }
  
  func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
  
}


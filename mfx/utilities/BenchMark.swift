//
//  BenchMark.swift
//  mfx
//
//  Created by 平賀義紀 on 2021/11/08.
//

import Foundation
import os

class Benchmark {

  // 開始時刻を保存する変数
  var startTime: Date
  var key: String

  // 処理開始
  init(key: String) {
    self.startTime = Date.now
    self.key = key
  }

  // 処理終了
  func finish() {
    let elapsed = Date().timeIntervalSince(self.startTime) as Double
    let formatedElapsed = String(format: "%.3f", elapsed)
    OSLog.mfx.info("Benchmark: \(self.key), Elasped second: \(formatedElapsed)")
  }

  // 処理をブロックで受け取る
  class func measure(key: String, block: () -> ()) {
    let benchmark = Benchmark(key: key)
    block()
    benchmark.finish()
  }
}

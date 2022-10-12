//
//  Units.swift
//  mfx
//
//  Created by 平賀義紀 on 2021/02/18.
//
import Foundation

public class Units {
  
  let FORMAT_BASIC = "%.2f"
  let FORMAT_COMPACT = "%.1f"

  let bytes: Int
  var format: String
  
  init(_ bytes: Int) {
    self.bytes = bytes
    self.format = self.FORMAT_COMPACT
  }

  var kilobytes: Double {
    return Double(bytes) / 1_024
  }
  
  var megabytes: Double {
    return kilobytes / 1_024
  }
  
  var gigabytes: Double {
    return megabytes / 1_024
  }
  
  var terabytes: Double {
    return gigabytes / 1_024
  }
  
  var petabytes: Double {
    return terabytes / 1_024
  }
  
  var BF : String {
    get {
      return "\(String.localizedStringWithFormat("%qu",bytes))B"
    }
  }
  
  var B : String {
    get {
      return "\(bytes)B"
    }
  }

  var KB : String {
    get {
      return "\(String.localizedStringWithFormat(format,kilobytes))K"
      //return "\(String(format: format, kilobytes))K"
    }
  }

  var MB : String {
    get {
      return "\(String(format: format, megabytes))M"
    }
  }

  var GB : String {
    get {
      return "\(String(format: format, gigabytes))G"
    }
  }

  var TB : String {
    get {
      return "\(String(format: format, terabytes))T"
    }
  }

  var PB : String {
    get {
      return "\(String(format: format, petabytes))P"
    }
  }

  var Auto : String {

    get {
      switch bytes {
        case 0..<1_024:
          return B
        case 1_024..<(1_024 * 1_024):
          return KB
        case 1_024..<(1_024 * 1_024 * 1_024):
          return MB
        case 1_024..<(1_024 * 1_024 * 1_024 * 1_024):
          return GB
        case 1_024..<(1_024 * 1_024 * 1_024 * 1_024 * 1_024):
          return TB
        case (1_024 * 1_024 * 1_024 * 1_024 * 1_024)...Int.max:
          return PB
        default:
          return B
      }
    }
  }
  
}

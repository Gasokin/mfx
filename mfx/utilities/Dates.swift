//
//  Dates.swift
//  mfx
//
//  Created by 平賀義紀 on 2021/11/10.
//

import Foundation

class Dates {
  
  static let formatter: DateFormatter = DateFormatter()
  static let calender = Calendar.current

  static func toString(_ date: Date?,_ format: String) -> String {
    
    guard let d = date else {
      return "Unkown Date"
    }
    
    formatter.calendar = Calendar(identifier: .gregorian)
    formatter.dateFormat = format
    return formatter.string(from: d)
  }
  
  static func toList(_ date: Date,_ format: String = "MM-dd") -> String {
    
    let year = calender.component(.year, from: date)
    
    if year == Status.i.CurrentYear {
      return toString(date,format)
    } else {
      return String(year)
    }

  }
  
}

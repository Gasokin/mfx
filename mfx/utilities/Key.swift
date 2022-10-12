//
//  KeyCodes.swift
//  mfx
//
//  Created by 平賀義紀 on 2020/10/10.
//

import Foundation
import Cocoa

struct Key {
  
  public static let A : UInt16 = 0
  public static let B : UInt16 = 11
  public static let C : UInt16 = 8
  public static let D : UInt16 = 2
  public static let E : UInt16 = 14
  public static let F : UInt16 = 3
  public static let G : UInt16 = 5
  public static let H : UInt16 = 4
  public static let I : UInt16 = 34
  public static let J : UInt16 = 38
  public static let K : UInt16 = 40
  public static let L : UInt16 = 37
  public static let M : UInt16 = 46
  public static let N : UInt16 = 45
  public static let O : UInt16 = 31
  public static let P : UInt16 = 35
  public static let Q : UInt16 = 12
  public static let R : UInt16 = 15
  public static let S : UInt16 = 1
  public static let T : UInt16 = 17
  public static let U : UInt16 = 32
  public static let V : UInt16 = 9
  public static let W : UInt16 = 13
  public static let X : UInt16 = 7
  public static let Y : UInt16 = 16
  public static let Z : UInt16 = 6
  public static let FULL_0 : UInt16 = 29
  public static let FULL_1 : UInt16 = 18
  public static let FULL_2 : UInt16 = 19
  public static let FULL_3 : UInt16 = 20
  public static let FULL_4 : UInt16 = 21
  public static let FULL_5 : UInt16 = 23
  public static let FULL_6 : UInt16 = 22
  public static let FULL_7 : UInt16 = 26
  public static let FULL_8 : UInt16 = 28
  public static let FULL_9 : UInt16 = 25
  public static let FULL_MINUS : UInt16 = 27
  public static let FULL_PLUS : UInt16 = 24
  public static let BRACKETS_LEFT : UInt16 = 33
  public static let BRACKETS_RIGHT : UInt16 = 30
  public static let YEN : UInt16 = 93
  public static let SEMICOLON : UInt16 = 41
  public static let COLON : UInt16 = 39
  public static let BACKTICKS : UInt16 = 39
  public static let COMMMA : UInt16 = 43
  public static let FULL_PERIOD : UInt16 = 47
  public static let FULL_SLASH : UInt16 = 44
  public static let F01 : UInt16 = 122
  public static let F02 : UInt16 = 120
  public static let F03 : UInt16 = 99
  public static let F04 : UInt16 = 118
  public static let F05 : UInt16 = 96
  public static let F06 : UInt16 = 97
  public static let F07 : UInt16 = 98
  public static let F08 : UInt16 = 100
  public static let F09 : UInt16 = 101
  public static let F10 : UInt16 = 109
  public static let F11 : UInt16 = 103
  public static let F12 : UInt16 = 111
  public static let F13 : UInt16 = 105
  public static let F14 : UInt16 = 107
  public static let F15 : UInt16 = 113
  public static let F16 : UInt16 = 106
  public static let F17 : UInt16 = 64
  public static let F18 : UInt16 = 79
  public static let F19 : UInt16 = 80
  public static let TAB : UInt16 = 48
  public static let CAPSLOCK : UInt16 = 57
  public static let SPACE : UInt16 = 49
  public static let RETURN : UInt16 = 36
  public static let SHIFT_LEFT : UInt16 = 56
  public static let SHIFT_RIGHT : UInt16 = 60
  public static let OPTION_LEFT : UInt16 = 58
  public static let OPTIONRIGHT : UInt16 = 61
  public static let CONTROL_LEFT : UInt16 = 59
  public static let CONTROL_RIGHT : UInt16 = 62
  public static let COMMAND_LEFT : UInt16 = 55
  public static let COMMAND_RIGHT : UInt16 = 54
  public static let DELETE : UInt16 = 51
  public static let ESC : UInt16 = 53
  public static let ARROW_LEFT : UInt16 = 123
  public static let ARROW_RIGHT : UInt16 = 124
  public static let ARROW_UP : UInt16 = 126
  public static let ARROW_DOWN : UInt16 = 125
  public static let FN : UInt16 = 63
  public static let DEL : UInt16 = 51
  public static let HOME : UInt16 = 123
  public static let END : UInt16 = 124
  public static let PAGE_UP : UInt16 = 116
  public static let PAGE_DOWN : UInt16 = 121
  public static let CLEAR : UInt16 = 71
  public static let NUM_EQUAL : UInt16 = 81
  public static let NUM_SLASH : UInt16 = 75
  public static let NUM_MULTIPLI : UInt16 = 67
  public static let NUM_MINUS : UInt16 = 78
  public static let NUM_PLUS : UInt16 = 69
  public static let NUM_ENTER : UInt16 = 76
  public static let NUM_PERIOD : UInt16 = 47
  public static let NUM_0 : UInt16 = 82
  public static let NUM_1 : UInt16 = 83
  public static let NUM_2 : UInt16 = 84
  public static let NUM_3 : UInt16 = 85
  public static let NUM_4 : UInt16 = 86
  public static let NUM_5 : UInt16 = 87
  public static let NUM_6 : UInt16 = 88
  public static let NUM_7 : UInt16 = 89
  public static let NUM_8 : UInt16 = 91
  public static let NUM_9 : UInt16 = 92
  
  static func toInstruction(_ code:UInt16,sft: Bool = false,ctl: Bool = false,cmd: Bool = false,opt: Bool = false) -> String {
    var rString = String(format: "%03d-",code)
    rString += sft ? "1" : "0"
    rString += ctl ? "1" : "0"
    rString += cmd ? "1" : "0"
    rString += opt ? "1" : "0"
    return rString
  }
  
  static func toInstruction(_ event: NSEvent) -> String {
    let mod = event.modifierFlags
    return toInstruction(event.keyCode,sft: mod.contains(.shift),ctl: mod.contains(.control),cmd: mod.contains(.command),opt: mod.contains(.option))
  }
  
}

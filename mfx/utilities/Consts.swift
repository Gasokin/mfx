//
//  Constants.swift
//  mfx
//
//  Created by 平賀義紀 on 2021/12/31.
//

import Foundation

class Consts {
  
  enum Progress: Int {
    case COPY = 0
    case MOVE = 1
    case DELETE = 2
  }
  
  enum Area: Int {
    case ListL = 0
    case ListR = 1
    case Message = 2
    case Detail = 3
    case ALL = 9
  }
  
  enum AreaName: String {
    case ListL = "ListLeft"
    case ListR = "ListRight"
    case Message = "Message"
    case Detail = "Detail"
    case ALL = "All"
  }
  
  enum ListStatus: Int {
    case Active = 0
    case InActive = 1
  }
  
  enum SortItem: String {
    case Name = "Name"
    case Date = "Date"
    case Size = "Size"
    case Ext = "Ext"
    case None = "None"
    case Copy = "Copy"
  }
  
  enum SortOrder: String {
    case Asc = "Asc"
    case Dsc = "Dsc"
  }

  enum ScreenSize {
    case Small
    case Middle
    case Large
    case Unkown
  }
  
  enum TypeObj: Int {
    case D = 0
    case F = 1
    case L = 2
    case A = 3
    case U = 4
  }
  
  static let TYPE_D = TypeObj.D.rawValue
  static let TYPE_F = TypeObj.F.rawValue
  static let TYPE_L = TypeObj.L.rawValue
  static let TYPE_A = TypeObj.A.rawValue
  static let TYPE_U = TypeObj.U.rawValue

  static let FILE_ATTRIBUTE = ["0":"---","1":"--x","2":"-w-","3":"-wx","4":"r--","5":"r-x","6":"rw-","7":"rwx"]
  
  static let UNKOWN_SIZE = -9
  static let UNKOWN_DATE = Date(timeIntervalSince1970: 0)
  
  static let TYPE_STRING = ["<DIR>","<FILE>","<LINK>","<ALIAS>","<UNKOWN>"]

  static let FILEMASK_SUBJECT = "ファイルマスクの指定"
  static let FILEMASK_COMMENT = """
                                表示したいファイル名の一部を入力してください。
                                正規表現が使用可能です。
                                空白で区切ると複数指定ができます。
                                未入力で確定することでマスク解除になります。
                                """
  static let PROGRESS_SUBJECT = ["複写","移動","削除"]
  static let PROGRESS_COMMENT = ["ファイルを複写します","ファイルを移動します","ファイルを削除します"]
}

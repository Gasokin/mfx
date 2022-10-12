//
//  ViewControllerKey.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/03/29.
//
import Foundation
import Cocoa
import os

extension VcMain {
  
  override func keyDown(with event: NSEvent) {

    if event.keyCode == Key.SPACE {
      viewA.object.toggleMark()
      viewA.cursor.down()
      return
    }
    
    if event.keyCode.equals(Key.RETURN,Key.NUM_ENTER) {
      executeObject()
      viewA.cursor.down()
      setDetail()
      return
    }
    
    if event.keyCode == Key.ARROW_LEFT {
      if viewA == vwL {
        if let u = viewA.url {
          setDir(viewA, u.deletingLastPathComponent())
        }
      } else {
        changeView()
      }
    }

    if event.keyCode == Key.ARROW_RIGHT {
      if viewA == vwR {
        if let u = viewA.url {
          setDir(viewA, u.deletingLastPathComponent())
        }
      } else {
        changeView()
      }
    }
    
    if event.keyCode == Key.L {
      segueViewer()
    }
    
    if event.keyCode == Key.C {
      segueProgress(Consts.Progress.COPY)
    }
    
    if event.keyCode == Key.COLON {
      segueInput(Consts.FILEMASK_SUBJECT,Consts.FILEMASK_COMMENT,self.setObjectMask(_:))
    }
    
    if event.keyCode == Key.K {
      remove()
      setDetail()
    }
    
    if event.keyCode == Key.D {
      if event.modifierFlags.contains(.command) {
        let order = event.modifierFlags.contains(.shift) ? Consts.SortOrder.Dsc : Consts.SortOrder.Asc
        viewA.sort(.Date,order)
        viewA.reloadData()
        setDetail()
      }
    }

    if event.keyCode == Key.N {
      if event.modifierFlags.contains(.command) {
        let order = event.modifierFlags.contains(.shift) ? Consts.SortOrder.Dsc : Consts.SortOrder.Asc
        viewA.sort(.Name,order)
        viewA.reloadData()
      }
    }

    if event.keyCode == Key.E {
      if event.modifierFlags.contains(.command) {
        let order = event.modifierFlags.contains(.shift) ? Consts.SortOrder.Dsc : Consts.SortOrder.Asc
        viewA.sort(.Ext,order)
        viewA.reloadData()
      }
    }

    if event.keyCode == Key.S {
      if event.modifierFlags.contains(.command) {
        let order = event.modifierFlags.contains(.shift) ? Consts.SortOrder.Dsc : Consts.SortOrder.Asc
        viewA.sort(.Size,order)
        viewA.reloadData()
      }
    }

  }
  
  override func keyUp(with event: NSEvent) {
    if event.keyCode.equals(Key.ARROW_UP,Key.ARROW_DOWN) {
      if let en: EntityObject = viewA.cursor.get() {
        setDetail(en)
      }
    }
  }
  
  private func changeView() {
    
    swap(&viewA,&viewD)
    viewA.firstResponder = true
    viewD.firstResponder = false
    viewA.tbList.reloadData()
    viewD.tbList.reloadData()

    if let en: EntityObject = viewA.cursor.get() {
      setDetail(en)
    }
  }
}

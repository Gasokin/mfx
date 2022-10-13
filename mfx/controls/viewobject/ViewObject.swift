//
//  ViewObjects.swift
//  mfx
//
//  Created by 平賀義紀 on 2022/08/28.
//

import Cocoa
import os

class ViewObject: NSVisualEffectView,NSFilePresenter {

  @IBOutlet var vwRoot: NSVisualEffectView!
  @IBOutlet weak var lbVolume: MFXVolumeField!
  @IBOutlet weak var lbDir: NSTextField!
  @IBOutlet weak var lbInfoDir: NSTextField!
  @IBOutlet weak var lbInfoMark: NSTextField!
  @IBOutlet weak var tbList: TableView! {
    didSet {
      self.tbList.backgroundColor = NSColor.clear
    }
  }

  var _api_main: VcMainAPI?
  var _current_url: URL?
  var _list = [EntityObject]()
  var _list_filter = [EntityObject]()
  var _fmgr = FileManager.default
  var _responder = false
  var _cfg: ConfigItemViewObject!

  var _filter_now = false
  var _filter_string: String? = nil
  
  var sort_kind = Consts.SortItem.Name
  var sort_order = Consts.SortOrder.Asc
  
  var cursor: ViewObjectApiCursor!
  var object: ViewObjectApiObject!

  let presentedItemOperationQueue = OperationQueue()
  var presentedItemURL: URL?

  var firstResponder: Bool {
    get {return _responder}
    set {
      _responder = newValue
      tbList.firstResponder = newValue
    }
  }
  
  var url: URL? {
    get {return _current_url}
  }
  
  var list: [EntityObject] {
    get {
      guard let _ = _filter_string else {
        return _list
      }
      return _list_filter
    }
    set {
      guard let _ = _filter_string else {
        _list = newValue
        return
      }
      _list_filter = newValue
    }
  }
  
  var config: ConfigItemViewObject {
    get {return _cfg}
    set {
      _cfg = newValue
      
      lbVolume.font = newValue.volume.Font.font
      lbDir.font = newValue.volume.Font.font
      lbInfoDir.font = newValue.info.Font.font
      lbInfoMark.font = newValue.mark.Font.font
      tbList.font = newValue.list.Font.font
    }
  }
  
  func reloadDir() {
    
    guard let u = _current_url else {
      return
    }

    DispatchQueue.main.async {
      let i = NSIndexSet(index: self.get() ?? 1) as IndexSet
      self.setDir(u,false)
      self.tbList.selectRowIndexes(i,byExtendingSelection: false)
      self._api_main!.setDetail()
    }
  }
  
  func reloadData(_ url: URL) {
    
    OSLog.mfx.info("reloadData Start \(url.path)")
    
    guard let u = _current_url else {
      OSLog.mfx.info("reloadData return")
      return
    }

    var row = 1
    if u.path == url.path {
      row = get() ?? 1
      OSLog.mfx.info("reloadData get \(row)")
    }

    OSLog.mfx.info("reloadData set \(url.path)")

    tbList.reloadData()
    set(row)
    OSLog.mfx.info("reloadData End \(row)")
  }
  
  func reloadData() {
    let row: EntityObject? = get()
    tbList.reloadData()
    
    if row == nil {
      set(0)
    } else {
      set(row!)
    }
  }

  /// 指定されたディレクトリの情報を表示する
  /// - Parameter u: 表示先のディレクトリ
  @discardableResult
  func setDir(_ url: URL,_ addListener: Bool = true) -> String? {

    _current_url = url
    var u3 = url
    
    // 存在しない場合は終了
    var isDir: ObjCBool = false
    if !_fmgr.fileExists(atPath: url.path, isDirectory: &isDir) {
      OSLog.mfx.info("ディレクトリが存在しません")
      return "ディレクトリが存在しません"
    }

    // 対象のリソースを取得して種類を判別
    guard var res = Objects.getResource(u3) else {
      OSLog.mfx.info("リソースの取得に失敗しました")
      return "リソースの取得に失敗しました"
    }
    var type = Objects.getType(res)

    // リンクとエイリアスは実体リソースを取得して以降はそれを使う
    if type == .L || type == .A {
      guard let u2 = Objects.resolveLink(url) else {
        OSLog.mfx.info("リンク元の取得に失敗しました")
        return "リンク元の取得に失敗しました"
      }
      guard let r2 = Objects.getResource(u2) else {
        OSLog.mfx.info("リンク元のリソース取得に失敗しました")
        return "リンク元のリソース取得に失敗しました"
      }
      u3 = u2
      res = r2
      type = Objects.getType(r2)
    }

    // ディレクトリ以外なら終了
    if type != .D {
      OSLog.mfx.info("ディレクトリ以外は指定できません")
      return "ディレクトリ以外は指定できません"
    }

    // ボリューム情報を取得
    let vol = EntityVolume()
    vol.name = res.volumeName ?? "Unkown"
    vol.size_t = res.volumeTotalCapacity ?? 0
    vol.size_f = res.volumeAvailableCapacity ?? 0
    vol.size_u = vol.size_t - vol.size_f

    // 配下のオブジェクト一覧を取得
    _list = Objects.getSubObjet(u3)

    // フィルタリング中はその表示にする
    if let fs = _filter_string {
      setObjectMask(fs)
    } else {
      lbDir.stringValue = "\(url.path)/"
    }

    if list.count > 0 {
      set(0)
    }

    lbVolume.set(vol)

    let info = Objects.getInfoDir(list)
    lbInfoDir.stringValue = info.toString()

    let mark = Objects.getMarkDir(list)
    lbInfoMark.stringValue = mark.toString()

    sort(sort_kind,sort_order)
    reloadData(url)

    if addListener {
      addFilePresenter(url: url)
    }
    
    self._api_main?.setDetail()
    return nil
  }
  
  func sort(_ kind: Consts.SortItem,_ order: Consts.SortOrder = .Asc) {
    
    sort_kind = kind
    sort_order = order
    
    var sort = (order == .Asc) ? Sorts.byName(.Asc) : Sorts.byName(.Dsc)
    switch kind {
      case .Date:
        sort = (order == .Asc) ? Sorts.byDate(.Asc) : Sorts.byDate(.Dsc)
      case .Size:
        sort = (order == .Asc) ? Sorts.bySize(.Asc) : Sorts.bySize(.Dsc)
      case .Ext:
        sort = (order == .Asc) ? Sorts.byExt(.Asc) : Sorts.byExt(.Dsc)
      default:
        sort = (order == .Asc) ? Sorts.byName(.Asc) : Sorts.byName(.Dsc)
    }

    let list_d = list.filter() {return $0.type == .D}.sorted(by: sort)
    let list_l = list.filter() {return $0.type == .L}.sorted(by: sort)
    let list_a = list.filter() {return $0.type == .A}.sorted(by: sort)
    let list_f = list.filter() {return $0.type == .F}.sorted(by: sort)
    
    list = list_d + list_l + list_a + list_f
    
    _cfg.sort_item = kind.rawValue
    _cfg.sort_order = order.rawValue
  }
  
  func addFilePresenter() {
    guard let u = url else {
      return
    }
    addFilePresenter(url: u)
  }

  func addFilePresenter(url: URL) {

    guard let p = presentedItemURL else {
      presentedItemURL = url
      NSFileCoordinator.addFilePresenter(self)
      return
    }

    if p.path == url.path {
      return
    }

    removeFilePresenter()
    presentedItemURL = url
    NSFileCoordinator.addFilePresenter(self)
  }
  
  func removeFilePresenter() {
    
    guard let _ = presentedItemURL else {
      return
    }
    
    NSFileCoordinator.removeFilePresenter(self)
    presentedItemURL = nil
  }
  
  func presentedSubitemDidChange(at url: URL) {
    
    guard let u = _current_url else {
      return
    }
    
    OSLog.mfx.info("presentedSubitemDidChange: \(u.path)  \(url.path)")

    if url.deletingLastPathComponent().path == u.path {
      reloadDir()
    }
  }

  required init?(coder decoder: NSCoder) {
    super.init(coder: decoder)
    setup()
  }
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    setup()
  }

  override func layout() {
    frame = bounds
    vwRoot.frame = bounds
  }
  
  func setup() {
    var topLevelArray: NSArray? = nil
    let bundle = Bundle(for: type(of: self))
    let nib = NSNib(nibNamed: .init(String(describing: type(of: self))), bundle: bundle)!
    nib.instantiate(withOwner: self, topLevelObjects: &topLevelArray)
    addSubview(vwRoot)

    cursor = self
    object = self
  }
}

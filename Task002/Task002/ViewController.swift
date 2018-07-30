//
//  ViewController.swift
//  Task002
//
//  Created by Ankit Kumar Bharti on 30/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @objc dynamic var nodes: [Node] = []
    @objc dynamic var values: [String] = []
    @IBOutlet weak var outlineView: NSOutlineView!
    @IBOutlet weak var tableView: NSTableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outlineView.registerForDraggedTypes([.string])
        tableView.registerForDraggedTypes([.string])
    }
}

// MARK:- NSOutlineViewDataSource for Drag Operation
extension ViewController: NSOutlineViewDataSource {
    
    func outlineView(_ outlineView: NSOutlineView, pasteboardWriterForItem item: Any) -> NSPasteboardWriting? {
        guard let node = (item as! NSTreeNode).representedObject as? Node else { return nil }
        let pasteboardItem = NSPasteboardItem()
        guard let data = node.encode else { return nil }
        pasteboardItem.setString(String(data: data, encoding: .utf8)!, forType: .string)
        return pasteboardItem
    }
}

// MARK:- NSTableViewDataSource for Drop Operation
extension ViewController: NSTableViewDataSource {
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        return .copy
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        let pasteboard = info.draggingPasteboard()
        guard let dataString = pasteboard.string(forType: .string), let data = dataString.data(using: .utf8), let node = Node.decode(data) else { return false }
        if !values.contains(node.title) {
            values.append(node.title)
        }
        if !node.child.isEmpty {
            let _ = node.child.map {[weak self] in
                if !values.contains($0.title) {
                    self?.values.append($0.title)
                }
            }
        }
        return true
    }
}

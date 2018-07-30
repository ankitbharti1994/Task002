//
//  DataModel.swift
//  Task001
//
//  Created by Ankit Kumar Bharti on 30/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

class Node: NSObject, Codable {
    @objc dynamic var title: String = "Untitled"
    @objc dynamic var child: [Node] = []
    
    var encode: Data? {
        let jsonEncoder = JSONEncoder()
        return try? jsonEncoder.encode(self)
    }
    
    class func decode(_ data: Data) -> Node? {
        let decoder = JSONDecoder()
        return try? decoder.decode(Node.self, from: data)
    }
}

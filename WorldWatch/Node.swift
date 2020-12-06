//
//  Node.swift
//  WorldWatch
//
//  Created by emery on 11/26/20.
//  Copyright © 2020 emery. All rights reserved.
//

import Foundation


class Node<T> {
    
    var value: T
    weak var parent: Node?
    var children = [Node<T>]()
    
    init(_ value: T) {
        self.value = value
    }
    
    func add(_ node: Node<T>) {
        children.append(node)
        node.parent = self
    }
    
    func desc(_ s:String? = nil) -> String {
        var me = String(describing:self.value)
        if let prev = s {
            me += "/" + prev
        }
        return self.parent?.desc(me) ?? me
    }
    
    // CST
    func localized() -> String? {
        guard let tz = TimeZone.init(identifier: self.desc()) else {
            return "ERROR"
        }
        var str: String? = ""
        if (tz.isDaylightSavingTime(for: Date())) {
            str = tz.localizedName(for: .shortDaylightSaving, locale: .current)
        } else {
            str = tz.localizedName(for: .shortStandard, locale: .current)
        }
        return str
    }
}

extension Node: CustomStringConvertible {
    private func display(level:Int) -> String {
        let offset = String(repeating: " ", count: level * 4)
        var s = offset + String(describing: value)
        if children.isEmpty { return s }
        s += " {\n"
        s += children.map { $0.display(level:level+1) }.joined(separator: ",\n")
        s += "\n\(offset)}"
        return s
    }
    var description: String { return display(level:0) }
}

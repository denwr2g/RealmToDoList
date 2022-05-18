//
//  Category.swift
//  RealmDB
//
//  Created by deniss.lobacs on 15/04/2022.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}

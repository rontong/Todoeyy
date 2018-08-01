//
//  Item.swift
//  Todoeyy
//
//  Created by Ronald Tong on 1/8/18.
//  Copyright © 2018 StokeDesign. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var checked: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

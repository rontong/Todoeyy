//
//  Category.swift
//  Todoeyy
//
//  Created by Ronald Tong on 1/8/18.
//  Copyright © 2018 StokeDesign. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}

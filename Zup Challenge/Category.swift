//
//  Category.swift
//  Zup Challenge
//
//  Created by Kayron Cabral on 29/12/16.
//  Copyright © 2016 Zup. All rights reserved.
//

import Foundation

class Category: NSObject {

    var title: String?
    var items = [String]()
    
    override init() {
        super.init()
    }
    
    init(title: String, items: [String]) {
        self.title = title
        self.items = items
    }
    
}

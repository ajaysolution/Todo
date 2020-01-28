//
//  Item.swift
//  Todo
//
//  Created by Ajay Vandra on 1/28/20.
//  Copyright © 2020 Ajay Vandra. All rights reserved.
//

import Foundation

class Item:Codable{
    var itemName:String = ""
    var done:Bool = false
    var category:String = ""
}

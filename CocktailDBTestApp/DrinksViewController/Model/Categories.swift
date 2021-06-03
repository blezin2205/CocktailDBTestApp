//
//  Categories.swift
//  MyCocktailApp
//
//  Created by Blezin on 07.09.2020.
//  Copyright © 2020 Blezin'sDev. All rights reserved.
//

import Foundation

 class Drinks: Decodable {
    
    let drinks: [Categories]
}

class Categories: Decodable {
    
    var name: String
    var filtered = true

    enum CodingKeys: String, CodingKey {
           case name = "strCategory"
           
       }
    
    
}

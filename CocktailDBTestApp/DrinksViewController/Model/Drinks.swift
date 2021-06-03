//
//  Drinks.swift
//  MyCocktailApp
//
//  Created by Blezin on 08.09.2020.
//  Copyright © 2020 Blezin'sDev. All rights reserved.
//

import Foundation

class Drink: Decodable {
    
    let drinks: [DrinksName]
}
class DrinksName: Decodable {
    
    var name: String
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case imageUrl = "strDrinkThumb"
    }
}

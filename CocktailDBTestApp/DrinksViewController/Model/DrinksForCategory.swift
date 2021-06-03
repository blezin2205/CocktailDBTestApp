//
//  DrinksForCategory.swift
//  MyCocktailApp
//
//  Created by Blezin on 08.09.2020.
//  Copyright © 2020 Blezin'sDev. All rights reserved.
//

import UIKit


class DrinksForCategory {
    
    var categoryName: String
    var drinksArray: [DrinksName]
    
    
    init(categoryName: String, drinksName: [DrinksName] ) {
        self.categoryName = categoryName
        self.drinksArray = drinksName
       
    }
    
}


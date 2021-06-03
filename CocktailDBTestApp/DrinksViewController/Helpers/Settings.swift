//
//  Settings.swift
//  CocktailDBTestApp
//
//  Created by Blezin on 01.06.2021.
//

import Foundation

class Settings {
    
   static let shared = Settings()
    
    var categories = [Categories]()
    var filltredCategories: [Categories]? {
        categories.filter({$0.filtered})
    }

    let url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list"
    let urlFilter = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?"
    
}

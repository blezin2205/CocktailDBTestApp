//
//  NetworkManager.swift
//  CocktailDBTestApp
//
//  Created by Blezin on 01.06.2021.
//

import Foundation

class NetworkManager {
    
   private let settings = Settings.shared
    
    private func fetchCategories(from link: String, completion: @escaping (Result<[Categories], Error>) -> Void)  {
        
        guard let url = URL(string: link) else { return }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let categories = try decoder.decode(Drinks.self, from: data)
                completion(.success(categories.drinks))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    private func fetchDrinksForCategory(url: String, params: [String: String],  completion: @escaping (Result<Drink, Error>) -> Void) {
        
        let urlComp = NSURLComponents(string: url)!
        var items = [URLQueryItem]()
        
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        session.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let drink = try decoder.decode(Drink.self, from: data)
                completion(.success(drink))
            } catch let error { completion(.failure(error)) }
        }.resume()
    }
    
    func startFetch(sectionIndex: Int, completion: @escaping (Result<DrinksForCategory, Error>) -> Void) {
        
        if settings.categories.isEmpty {
            fetchCategories(from: settings.url) { result in
                switch result {
            
                case .success(let categories):
                    self.settings.categories = categories
                    self.fetchDrinksForCategory(url: self.settings.urlFilter, params: ["c" : categories[sectionIndex].name]) { result in
                        switch result {
                        
                        case .success(let drinks):
                            completion(.success(DrinksForCategory(categoryName: categories[sectionIndex].name,
                                                                  drinksName: drinks.drinks)))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            guard let filteredCategories = settings.filltredCategories else {return}
            fetchDrinksForCategory(url: settings.urlFilter, params: ["c" : filteredCategories[sectionIndex].name]) { result in
                switch result {
                
                case .success(let drinks):
                    completion(.success(DrinksForCategory(categoryName: filteredCategories[sectionIndex].name,
                                                          drinksName: drinks.drinks)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
    }
    
    
    
}

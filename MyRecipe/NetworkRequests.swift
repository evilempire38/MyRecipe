//
//  NetworkRequests.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 27.01.2022.
//


import Foundation
import UIKit
final class NetworkRequests {
    var requestCounter : Int = 0
    let usrdfltsmng = UserDefaults.standard
    
    
    
    var urlConstructorRecipe : URLComponents {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.spoonacular.com"
        urlConstructor.path = "/recipes/random"
        urlConstructor.queryItems = [
            URLQueryItem(name: "number", value: "3"),
            URLQueryItem(name: "apiKey", value: "41e2c193b894412f8cc14827b6b38630")]
        return urlConstructor
    }
    
    
    
    func fetchRandomRecipe(completion : @escaping ([Recipe]) -> Void) {
        let session = URLSession(configuration: .default)
        guard let url = urlConstructorRecipe.url else {return}
        var currentCounter = usrdfltsmng.integer(forKey: "counter")
        currentCounter += 1
        self.usrdfltsmng.set(currentCounter, forKey: "counter")
        print(usrdfltsmng.integer(forKey: "counter"))
        let task = session.dataTask(with: url) { data, response, err in
            if let err = err {
                print(err.localizedDescription)
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let recipe = try decoder.decode(RecipeModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(recipe.recipes)
                    }

                } catch let error {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func fetchCatRec(param : String, completion : @escaping ([Recipe]) -> Void) {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.spoonacular.com"
        urlConstructor.path = "/recipes/random"
        urlConstructor.queryItems = [
            URLQueryItem(name: "number", value: "100"),
            URLQueryItem(name: "apiKey", value: "41e2c193b894412f8cc14827b6b38630"),
            URLQueryItem(name: "tags", value: param)]
        
        let session = URLSession(configuration: .default)
        guard let url = urlConstructor.url else {return}
        var currentCounter = usrdfltsmng.integer(forKey: "counter")
        currentCounter += 1
        self.usrdfltsmng.set(currentCounter, forKey: "counter")
        print(usrdfltsmng.integer(forKey: "counter"))
        let task = session.dataTask(with: url) { data, response, err in
            if let err = err {
                print(err.localizedDescription)
            }
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
                
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let recipe = try decoder.decode(RecipeModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(recipe.recipes)
                    }
                } catch let error {
                    print(error)
                }
            }
        }
        task.resume()
        
    }
    
}

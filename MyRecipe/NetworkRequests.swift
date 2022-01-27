//
//  NetworkRequests.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 27.01.2022.
//


import Foundation
final class NetworkRequests {
    
    var urlConstructorRandomRecipe : URLComponents {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.spoonacular.com"
        urlConstructor.path = "/recipes/random"
        urlConstructor.queryItems = [URLQueryItem(name: "number", value: "3"),
        URLQueryItem(name: "apiKey", value: "41e2c193b894412f8cc14827b6b38630")]
        return urlConstructor
    }
    
    func fetchRandomRecipe(completion : @escaping ([Recipe]) -> Void) {
        let session = URLSession(configuration: .default)
        guard let url = urlConstructorRandomRecipe.url else {return}
        let task = session.dataTask(with: url) { data, response, err in
            if let err = err {
                print(err.localizedDescription)
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json)
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

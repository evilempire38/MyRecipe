//
//  MeditherianTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 02.02.2022.
//

import UIKit

class MeditherianTableViewController: UITableViewController {
    var recipies = [Recipe]()
    let request = NetworkRequests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mediterranean kitchen"
        
        request.fetchRecipe { [weak self]  recipe in
            guard let self = self else {return}
            self.recipies = self.sortByKitchen(array: recipe)

            self.tableView.reloadData()
            
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipies.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "medCell", for: indexPath)
        let object = recipies[indexPath.row]
        cell.textLabel?.text = object.title
        
        return cell
    }
    
    private func sortByKitchen (array : [Recipe]) -> [Recipe] {
        var newArray = [Recipe]()
        for element in array {
            for kitchen in element.cuisines {
                if kitchen == "Mediterranean" {
                    newArray.append(element)
                }
            }
        }
        return newArray
    }
    
}



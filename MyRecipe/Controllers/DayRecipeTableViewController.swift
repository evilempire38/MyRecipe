//
//  DayRecipeTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 27.01.2022.
//

import UIKit

class DayRecipeTableViewController: UITableViewController {
    let networkRequests = NetworkRequests()
    var myRecipe = [Recipe]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recipe of the day"
        networkRequests.fetchRandomRecipe { [weak self] recipe in
            guard let self = self else {return}
            self.myRecipe = recipe
            self.tableView.reloadData()
        }

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayRecipeCell", for: indexPath) as! DayRecipeTableViewCell
        let object = myRecipe[indexPath.row]
        cell.recipeTitle.text = object.title
        cell.recipeRating.text = "\(object.aggregateLikes)"
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myRecipe.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }

}

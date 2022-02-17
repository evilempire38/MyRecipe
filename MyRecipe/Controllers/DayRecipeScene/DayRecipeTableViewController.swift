//
//  DayRecipeTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 27.01.2022.
//

import UIKit
import Kingfisher

class DayRecipeTableViewController: UITableViewController {
    let networkRequests = NetworkRequests()
    var myRecipe = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Day Recipe"
        networkRequests.fetchRandomRecipe { [weak self] myData in
            guard let self = self else {return}
            self.myRecipe = myData
            self.tableView.reloadData()
        }

        }

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kitchenCell", for: indexPath) as! RecipeListTableViewCell
        let object = myRecipe[indexPath.row]
        let urlforImage = URL(string: object.image ?? "")
        cell.reciepeImage.kf.setImage(with: urlforImage)
        cell.recipeTitle.text = object.title
        cell.recipeTitle.numberOfLines = 0
        cell.recipeTitle.lineBreakMode = .byWordWrapping
        cell.recipeHealthScore.text = "Health score : \(object.healthScore)"
        cell.recipeTimeToReady.text = "\(object.readyInMinutes) min to ready"
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myRecipe.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail2" {
            guard let neededVC = segue.destination as? DetailCurrentRecipeViewController else {return}
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let object = myRecipe[indexPath.row]
            neededVC.recipe = object
            
        }
    }

}

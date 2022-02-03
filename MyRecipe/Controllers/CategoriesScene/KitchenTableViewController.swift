//
//  MeditherianTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 02.02.2022.
//

import UIKit
import Kingfisher

class KitchenTableViewController: UITableViewController {
    var recipies = [Recipe]()
    let request = NetworkRequests()
    let categVC = CategotiesViewController()
    var titleKitchenLabel : String = ""
    var filterKeyWord : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(titleKitchenLabel) kitchen"
        
        request.fetchRecipe { [weak self]  recipe in
            guard let self = self else {return}
            self.recipies = self.categVC.filterRecipes(with: recipe, by: self.filterKeyWord)
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipies.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kitchenCell", for: indexPath) as! KitcheTableViewCell
        let object = recipies[indexPath.row]
        let urlforImage = URL(string: object.image ?? "")
        cell.reciepeImage.kf.setImage(with: urlforImage)
        cell.recipeTitle.numberOfLines = 0
        cell.recipeTitle.text = object.title
        cell.recipeHealthScore.text = "Health score : \(object.healthScore)"
        cell.recipeTimeToReady.text = "\(object.readyInMinutes) min to ready"
        return cell
    }
}



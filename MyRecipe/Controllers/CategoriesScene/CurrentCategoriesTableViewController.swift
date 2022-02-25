//
//  MeditherianTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 02.02.2022.
//

import UIKit


class CurrentCategoriesTableViewController: UITableViewController {

    var recipies = [Recipe]()
    let request = NetworkRequests()
    var titleCategoryType : String = ""
    var paramForRequest : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.title = "\(titleCategoryType)"
        request.fetchCatRec(param: paramForRequest) { [weak self] product in
            guard let self = self else {return}
            self.recipies = product.shuffled()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kitchenCell", for: indexPath) as! RecipeListTableViewCell
        let object = recipies[indexPath.row]
        
        if let stringForURL = object.image {
            
            cell.activityIndicator.startAnimating()
            self.request.fetchImage(stringForURL) { [weak self] image in
                
                cell.reciepeImage.image = image
                cell.activityIndicator.stopAnimating()
            }
        }
        cell.recipeTitle.text = object.title
        cell.recipeTitle.numberOfLines = 0
        cell.recipeTitle.lineBreakMode = .byWordWrapping
        cell.recipeHealthScore.text = "Health score : \(object.healthScore)"
        cell.recipeTimeToReady.text = "\(object.readyInMinutes) min to ready"
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            guard let neededVC = segue.destination as? DetailRecipeViewController else {return}
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let object = recipies[indexPath.row]
            neededVC.recipe = object
            
        }
    }
    
}



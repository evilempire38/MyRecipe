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
        let urlForImage = URL(string: object.image)
        
        cell.recipeTitle.text = object.title
        cell.recipeRating.text = "\(object.aggregateLikes)"
        cell.recipeTitle.numberOfLines = 0
        cell.recipeImage.kf.setImage(with: urlForImage)
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myRecipe.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let currentVC = segue.source as? DayRecipeTableViewController
            guard let indexPath = self.tableView.indexPathForSelectedRow else {return}
            let object = currentVC?.myRecipe[indexPath.row]
            if let detailVC = segue.destination as? DayRecipeDetailViewController {
                detailVC.DetailNameVCtitle = object?.title
                detailVC.recipeImageString = object?.image ?? ""
                detailVC.recipeDescriptionString = object?.instructions ?? "Here should be recipe"

            
        }
    }

}
}

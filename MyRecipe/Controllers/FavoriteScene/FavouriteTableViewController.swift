//
//  FavouriteTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 17.02.2022.
//

import UIKit
import CoreData


class FavouriteTableViewController: UITableViewController {
    var favouriteRecipe : [MyFavouriteRecipes] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Favourites"
        loadMyFavouriteRecipes()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMyFavouriteRecipes()
        self.tableView.reloadData()
    }
    private func loadMyFavouriteRecipes () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let request = NSFetchRequest<MyFavouriteRecipes>(entityName: "MyFavouriteRecipes")
        let context = appDelegate.coreDataStack.persistentContainer.viewContext
        
        do {
            favouriteRecipe = try context.fetch(request)
            print(favouriteRecipe)
        }
        catch  let error {
            print(error)
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return favouriteRecipe.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as! RecipeListTableViewCell
        let object = favouriteRecipe[indexPath.row]
        if let dataImage = object.image {
            guard let image : UIImage = UIImage(data: dataImage) else {return UITableViewCell()}
            cell.reciepeImage.image = image
        }
        cell.recipeTitle.text = object.title
        cell.recipeHealthScore.text = object.healthScore.description
        cell.recipeTimeToReady.text = object.readyInMinutes.description
        
        
        return cell
    }

}

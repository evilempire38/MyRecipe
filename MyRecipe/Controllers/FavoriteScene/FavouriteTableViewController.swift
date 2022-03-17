//
//  FavouriteTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 17.02.2022.
//

import UIKit
import CoreData


class FavouriteTableViewController: UITableViewController {
    let coreDataStack = CoreDataStack()
    var favouriteRecipe : [MyFavouriteRecipes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favourites"
        prepareTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareTableView()
        tableView.reloadData()
        
    }
    
    private func loadMyFavouriteRecipes () {
        let request = NSFetchRequest<MyFavouriteRecipes>(entityName: "MyFavouriteRecipes")
        let context = coreDataStack.persistentContainer.viewContext
        do {
            favouriteRecipe = try context.fetch(request)
            print(favouriteRecipe)
        }
        catch
        {
            callAC(title: "Oops!", message: "Something happened", style: .alert)
        }
    }
    
    private func prepareTableView(){
        loadMyFavouriteRecipes()
        tableView.tableFooterView = UIView()
        
    }
     func callAC (title : String, message : String, style : UIAlertController.Style) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
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
        cell.recipeHealthScore.text = "Health score : \(object.healthScore)"
        cell.recipeTimeToReady.text = "\(object.readyInMinutes) min to ready"
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = coreDataStack.persistentContainer.viewContext
            let recipe = favouriteRecipe[indexPath.row]
            context.delete(recipe)
            do {
                try context.save()
            }
            catch {
                callAC(title: "Oops!", message: "Something happened", style: .alert)
            }
            favouriteRecipe.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "favouriteSegue" {
            guard let neededVC = segue.destination as? DetailRecipeViewController else {return}
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let object = favouriteRecipe[indexPath.row]
            neededVC.coreDataRecipe = object
            neededVC.saveButton.isEnabled = false
            
        }
    }
    
}

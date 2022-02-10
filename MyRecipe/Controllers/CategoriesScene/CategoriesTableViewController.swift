//
//  CategoriesTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 10.02.2022.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    let titleForVC : String = "Categories"
    let categories : [LocalModelForCategories] = [
        LocalModelForCategories(category: "Breakfast", imageCategory: "breakfast"),
        LocalModelForCategories(category: "Lunch", imageCategory: "lunch"),
        LocalModelForCategories(category: "Dinner", imageCategory: "dinner"),
        LocalModelForCategories(category: "Soups", imageCategory: "soup"),
        LocalModelForCategories(category: "Salads", imageCategory: "salad"),
        LocalModelForCategories(category: "Desserts", imageCategory: "desert"),
        LocalModelForCategories(category: "Drinks", imageCategory: "drinks"),
        LocalModelForCategories(category: "Vegetarian", imageCategory: "vegeterian")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titleForVC
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].category
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath) as! CategoriesTableViewCell
        let object = categories[indexPath.section]
        cell.categoryImage.image = object.image
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "catSegue" {
            guard let neededVC = segue.destination as? CurrentCategoriesTableViewController else {return}
            guard let currentVC = segue.source as? CategoriesTableViewController else {return}
            guard let indexPath = currentVC.tableView.indexPathForSelectedRow else {return}
            let currentCell = categories[indexPath.section]
            let currentCategory = currentCell.category
            switch currentCategory {
                
            case "Breakfast" : neededVC.paramForRequest = "breakfast"
            case "Lunch" : neededVC.paramForRequest = "lunch"
            case "Dinner" : neededVC.paramForRequest = "dinner"
            case "Soups" : neededVC.paramForRequest = "soup"
            case "Salads" : neededVC.paramForRequest = "salad"
            case "Desserts" : neededVC.paramForRequest = "desserts"
            case "Drinks" : neededVC.paramForRequest = "drinks"
            case "Vegetarian" : neededVC.paramForRequest = "vegetarian"
                
            default:return
                
             }
        }
        
    }
}

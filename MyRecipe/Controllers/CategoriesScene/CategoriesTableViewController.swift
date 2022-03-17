//
//  CategoriesTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 10.02.2022.
//

import UIKit
import Network

class CategoriesTableViewController: UITableViewController {
    
    private var nwMonitor = NWPathMonitor()
    private let titleForVC : String = "Categories"
    private let infoVC : UIViewController = InfoUIViewController()
    private let categories : [LocalModelForCategories] = [
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
        nwMonitor.start(queue: .global())
        nwMonitor.pathUpdateHandler = { path in
            if path.status == .unsatisfied {
                DispatchQueue.main.async {
                    self.acUnsatisfiedNetwork()
                }
                
            }
        }

    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
                neededVC.titleCategoryType = currentCategory
            case "Lunch" : neededVC.paramForRequest = "lunch"
                neededVC.titleCategoryType = currentCategory
            case "Dinner" : neededVC.paramForRequest = "dinner"
                neededVC.titleCategoryType = currentCategory
            case "Soups" : neededVC.paramForRequest = "soup"
                neededVC.titleCategoryType = currentCategory
            case "Salads" : neededVC.paramForRequest = "salad"
                neededVC.titleCategoryType = currentCategory
            case "Desserts" : neededVC.paramForRequest = "desserts"
                neededVC.titleCategoryType = currentCategory
            case "Drinks" : neededVC.paramForRequest = "drinks"
                neededVC.titleCategoryType = currentCategory
            case "Vegetarian" : neededVC.paramForRequest = "vegetarian"
                neededVC.titleCategoryType = currentCategory
                
            default:return
                
            }
        }
        
    }
    private func acUnsatisfiedNetwork(){
        let ac = UIAlertController(title: "Sorry", message: "There is no internet connection. Most functions of app are unavailable", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        ac.addAction(okAction)
        self.present(ac, animated: true, completion: nil)
    }
}

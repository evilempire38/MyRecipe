//
//  IngridientsTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 14.02.2022.
//

import UIKit

final class IngredientsTableViewController: UITableViewController {
    
    
     var recipe : Recipe?
     var coreDataRecipe : MyFavouriteRecipes?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "IngredientsTableViewCell", bundle: nil), forCellReuseIdentifier: "ingredientsCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if coreDataRecipe == nil {
            return (recipe?.extendedIngredients.count) ?? 1
        } else {
            return coreDataRecipe?.extendedIngredients?.count ?? 1
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath) as! IngredientsTableViewCell
        if coreDataRecipe == nil {
            if let object = recipe?.extendedIngredients[indexPath.row] {
                cell.productLabel.text = object.name
                cell.amountLabel.text = object.measures.metric.amount.description + " " + object.measures.metric.unitLong
            }
            return cell
        } else {
            guard let extended = coreDataRecipe?.extendedIngredients?[indexPath.row] as? ExtendedIngredients else {return UITableViewCell()}
            guard let amountText = extended.measures?.metric?.amount , let unitText = extended.measures?.metric?.unitLong else {return UITableViewCell()}
            cell.productLabel.text = extended.name
            cell.amountLabel.text = amountText.description + " " + unitText.description
            
        }
        return cell
    }


    
    
}

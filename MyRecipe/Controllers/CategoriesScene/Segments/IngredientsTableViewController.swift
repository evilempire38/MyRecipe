//
//  IngridientsTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 14.02.2022.
//

import UIKit

class IngredientsTableViewController: UITableViewController {
    
    
    var recipe : Recipe?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "IngredientsTableViewCell", bundle: nil), forCellReuseIdentifier: "ingredientsCell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipe?.extendedIngredients.count) ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath) as! IngredientsTableViewCell
        if let object = recipe?.extendedIngredients[indexPath.row] {
            
            cell.productLabel.text = object.name
            cell.amountLabel.text = object.measures.metric.amount.description + " " + object.measures.metric.unitLong
        }

        
        
        return cell
    }


    
    
}

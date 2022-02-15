//
//  IngridientsTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 14.02.2022.
//

import UIKit

class IngridientsTableViewController: UITableViewController {
    
    
    var recipe : Recipe?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "IngridietnsTableViewCell", bundle: nil), forCellReuseIdentifier: "ingridientsCell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipe?.extendedIngredients.count) ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingridientsCell", for: indexPath) as! IngridietnsTableViewCell
        if let object = recipe?.extendedIngredients[indexPath.row] {
            
            cell.productLabel.text = object.name
            cell.amountLabel.text = object.measures.metric.amount.description + " " + object.measures.metric.unitLong
        }

        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

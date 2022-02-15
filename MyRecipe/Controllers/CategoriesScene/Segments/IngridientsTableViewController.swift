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
        tableView.register(IngridietnsTableViewCell.self, forCellReuseIdentifier: "ingridientsCell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return (recipe?.extendedIngredients.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingridientsCell", for: indexPath) as? IngridietnsTableViewCell
        let object = recipe?.extendedIngredients[indexPath.row]
        cell.productTitle.text = object?.name
        cell.amountTitle.text = object?.measures.metric.unitShort
        return cell
    }
    
    
}

//
//  StepsTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 14.02.2022.
//

import UIKit

class StepsTableViewController: UITableViewController {
    var recipe : Recipe?
    var coreDataRecipe : MyFavouriteRecipes?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "StepsTableViewCell", bundle: nil), forCellReuseIdentifier: "stepsCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if coreDataRecipe == nil {
            guard let object = recipe?.analyzedInstructions else { return 0 }
            if object.isEmpty {
                return 0
            } else  {
                return object[0].steps.count
            }
    }
        else {
            guard let object = coreDataRecipe?.analyzedInstructions?[0] as? AnalyzedInstructions else {return 0}
            return object.steps?.count ?? 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepsCell", for: indexPath) as! StepsTableViewCell
        if coreDataRecipe == nil {
            guard let object = recipe?.analyzedInstructions else { return UITableViewCell() }
            if object.isEmpty {
                return UITableViewCell()
            } else {
                cell.stepsDescriptionTitle.text = object[0].steps[indexPath.section].step
            }
            return cell
        } else {
            guard let object = coreDataRecipe?.analyzedInstructions?[0] as? AnalyzedInstructions else {return UITableViewCell()}
            guard let steps = object.steps?[indexPath.section] as? Steps else {return UITableViewCell()}
            cell.stepsDescriptionTitle.text = steps.step
            
        }
        return cell

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if coreDataRecipe == nil {
            guard let object = recipe?.analyzedInstructions else { return "nil" }
            return object[0].steps[section].number.description
        } else {
            guard let object = coreDataRecipe?.analyzedInstructions?[0] as? AnalyzedInstructions else {return ""}
            guard let description = object.steps?[section] as? Steps else {return ""}
            return description.number.description
        }

    }
    
    


}


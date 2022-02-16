//
//  StepsTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 14.02.2022.
//

import UIKit

class StepsTableViewController: UITableViewController {
    var recipe : Recipe?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "StepsTableViewCell", bundle: nil), forCellReuseIdentifier: "stepsCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let object = recipe?.analyzedInstructions else { return 0 }
        if object.isEmpty {
            return 0
        } else  {
            return object[0].steps.count
 
    }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepsCell", for: indexPath) as! StepsTableViewCell
        guard let object = recipe?.analyzedInstructions else { return UITableViewCell.init() }
        if object.isEmpty {
            
            return UITableViewCell.init()
            
        } else {
            cell.stepsDescriptionTitle.text = object[0].steps[indexPath.section].step
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let object = recipe?.analyzedInstructions else { return "nil" }
        return object[0].steps[section].number.description
    }
    
    


}


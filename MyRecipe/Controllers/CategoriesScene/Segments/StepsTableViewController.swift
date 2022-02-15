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

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.analyzedInstructions[0].steps.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepsCell", for: indexPath) as! StepsTableViewCell
        cell.stepsDescriptionTitle.text = recipe?.analyzedInstructions[0].steps[indexPath.row].step


        return cell
    }
    


}

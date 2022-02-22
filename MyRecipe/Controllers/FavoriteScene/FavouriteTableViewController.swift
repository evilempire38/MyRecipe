//
//  FavouriteTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 17.02.2022.
//

import UIKit

class FavouriteTableViewController: UITableViewController {
    var favouriteRecipe : [MyFavouriteRecipes] = []

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return favouriteRecipe.count
    }



}

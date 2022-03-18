//
//  SearchTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 16.02.2022.
//

import UIKit
import CoreData

final class SearchTableViewController: UITableViewController  {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchedRecipes : [Recipe] = []
    private let request = NetworkRequests()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSC()
    }
    

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedRecipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! RecipeListTableViewCell
        let object = searchedRecipes[indexPath.row]
        if let urlforImage = object.image {
            cell.activityIndicator.startAnimating()
            self.request.fetchImage(urlforImage) {  image in
                guard let image = image else {return}
                cell.reciepeImage.image = image
                cell.activityIndicator.stopAnimating()
            }
        }
        cell.recipeTitle.text = object.title
        cell.recipeTitle.numberOfLines = 0
        cell.recipeTitle.lineBreakMode = .byWordWrapping
        cell.recipeHealthScore.text = "Health score : \(object.healthScore)"
        cell.recipeTimeToReady.text = "\(object.readyInMinutes) min to ready"
        return cell
    }
    
    
}
extension SearchTableViewController :  UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let param = searchBar.text else {return}
        request.fetchCatRec(param: param ) {[weak self] myData in
            guard let self = self else {return}
            if myData.isEmpty {
                self.emptyAlert()
            } else {
                self.searchedRecipes = myData
                self.tableView.reloadData()
            }

        }
    }
    
    private func emptyAlert(){
        let ac = UIAlertController(title: "Sorry", message: "We can't offer anything at your request. Try another one", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    
    
    private func setupSC () {
        self.title = "Search"
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "a snack? or something else?"
        self.searchController.searchBar.autocapitalizationType = .none
        self.searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchID" {
            guard let neededVC = segue.destination as? DetailRecipeViewController else {return}
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let object = searchedRecipes[indexPath.row]
            neededVC.recipe = object
            
        }
    }
}

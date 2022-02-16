//
//  SearchTableViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 16.02.2022.
//

import UIKit

class SearchTableViewController: UITableViewController  {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchedRecipes : [Recipe] = []
    private var searchBarIsEmpty : Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
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
        let urlforImage = URL(string: object.image ?? "")
        cell.reciepeImage.kf.setImage(with: urlforImage)
        cell.recipeTitle.text = object.title
        cell.recipeTitle.numberOfLines = 0
        cell.recipeTitle.lineBreakMode = .byWordWrapping
        cell.recipeHealthScore.text = "Health score : \(object.healthScore)"
        cell.recipeTimeToReady.text = "\(object.readyInMinutes) min to ready"
        return cell
    }
    
    
}
extension SearchTableViewController : UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let param = searchBar.text else {return}
        request.fetchCatRec(param: param ) {[weak self] myData in
            guard let self = self else {return}
            self.searchedRecipes = myData
            self.tableView.reloadData()
        }
    }
    
    func setupSC () {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Input you desire"
        self.searchController.searchBar.autocapitalizationType = .none
        self.searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

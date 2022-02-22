//
//  DetailCurrentRecipeViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 14.02.2022.
//

import UIKit
import CoreData


class DetailCurrentRecipeViewController: UIViewController {
    let networkService = NetworkRequests()
    var recipe : Recipe?
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    let descriptionView = DescriptionViewController()
    let ingridientsView  = IngredientsTableViewController()
    let stepsView  = StepsTableViewController()
    var views : [UIView]!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = recipe?.title
        start()
        setupViews()


        
    }
    
    private func setupDescriptionVC() {
        descriptionView.descriptionOfRecipe = recipe?.summary.trimHTMLTags() ?? "empty"
        if let url = recipe?.image {
            networkService.fetchImage(url) { [weak self] image in
                guard let self = self else {return}
                self.imageView.image = image
            }
        }
    }
    private func setupIngridientsVC(){
        ingridientsView.recipe = recipe
    }
    private func setupStepsVC(){
        stepsView.recipe = recipe
    }
    private func start(){
        setupDescriptionVC()
        setupIngridientsVC()
        setupStepsVC()
    }
    private func setupViews() {
        views = [UIView]()
        descriptionView.view.frame = CGRect(x: 0, y: 0, width: viewContainer.frame.width, height: viewContainer.frame.height)
        ingridientsView.view.frame = CGRect(x: 0, y: 0, width: viewContainer.frame.width, height: viewContainer.frame.height)
        stepsView.view.frame = CGRect(x: 0, y: 0, width: viewContainer.frame.width, height: viewContainer.frame.height)
        views.append(descriptionView.view)
        views.append(ingridientsView.view)
        views.append(stepsView.view)
        for view in views {
            viewContainer.addSubview(view)
        }
        viewContainer.bringSubviewToFront(views[0])
    }


    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        self.viewContainer.bringSubviewToFront(views[sender.selectedSegmentIndex])
    }
    
    @IBAction func saveToFavouriteList(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let coreDataContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "MyFavouriteRecipes", in: coreDataContext) else {return}
        let recipeObject = MyFavouriteRecipes(entity: entity, insertInto: coreDataContext)
        
    }
}

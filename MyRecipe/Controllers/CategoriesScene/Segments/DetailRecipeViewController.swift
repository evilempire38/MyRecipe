//
//  DetailCurrentRecipeViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 14.02.2022.
//

import UIKit
import CoreData


class DetailRecipeViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    let networkService = NetworkRequests()
    var recipe : Recipe?
    let descriptionView = DescriptionViewController()
    let ingridientsView  = IngredientsTableViewController()
    let stepsView  = StepsTableViewController()
    var views : [UIView]!
 
    override func viewDidLoad() {
        saveButton.isEnabled = false
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
    
    private func saveToCoreData () {
        let context = CoreDataStack().persistentContainer.viewContext
        guard let mainRecipeEntity = NSEntityDescription.entity(forEntityName: "MyFavouriteRecipes", in: context) else {return}
        let myRecipe = MyFavouriteRecipes(entity: mainRecipeEntity, insertInto: context)
        guard let imageData = imageView.image?.pngData() else {return}
        guard let neededRecipe = recipe else {return}
        myRecipe.title = neededRecipe.title
        myRecipe.image = imageData
        myRecipe.healthScore = Int16(neededRecipe.healthScore)
        myRecipe.readyInMinutes = Int16(neededRecipe.readyInMinutes)
        myRecipe.id = Int16(neededRecipe.id)
        myRecipe.summary = neededRecipe.summary
        myRecipe.analyzedInstructions = NSOrderedSet(array: neededRecipe.analyzedInstructions)
        myRecipe.extendedIngredients = NSOrderedSet(array: neededRecipe.extendedIngredients)
        
        
        do {
            try context.save()
        }
        catch let err as NSError {
            print(err)
        }


    }


    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        self.viewContainer.bringSubviewToFront(views[sender.selectedSegmentIndex])
    }
    
    @IBAction func saveToFavouriteList(_ sender: Any) { 
        saveToCoreData()
        
    }
    
}

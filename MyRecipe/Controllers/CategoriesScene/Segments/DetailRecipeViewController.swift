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

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.coreDataStack.persistentContainer.viewContext
        guard let imageData = imageView.image?.pngData() else {return}
        guard let neededRecipe = recipe else {return}
        let myRecipe = MyFavouriteRecipes(context: context)
        myRecipe.title = neededRecipe.title
        myRecipe.image = imageData
        myRecipe.healthScore = Int16(neededRecipe.healthScore)
        myRecipe.readyInMinutes = Int16(neededRecipe.readyInMinutes)
        myRecipe.id = Int32(neededRecipe.id)
        myRecipe.summary = neededRecipe.summary
        myRecipe.vegetarian = neededRecipe.vegetarian
        
        // делаем связь внутри коредаты и создаем зависимые объекты
        neededRecipe.analyzedInstructions.forEach { analyzedInstruction in
            let analyzedInstructionCoreData = AnalyzedInstructions(context:  context)
            analyzedInstructionCoreData.name = analyzedInstruction.name
            print(analyzedInstruction.name)
            analyzedInstructionCoreData.myRecipe = myRecipe
            
            // сохраним объект steps в базе CoreData
            analyzedInstruction.steps.forEach{ step in
                let stepCoreData = Steps(context:  context)
                stepCoreData.number = Int64(step.number)
                stepCoreData.step = step.step
                stepCoreData.analyzedInstr = analyzedInstructionCoreData
                
            }
        }
        neededRecipe.extendedIngredients.forEach { extendedIngredietns in
        
            let extendedIngredietnsCoreData = ExtendedIngredients(context: context)
            extendedIngredietnsCoreData.name = extendedIngredietns.name
            extendedIngredietnsCoreData.myRecipe = myRecipe
            
            let measuresCoreData = Measure(context: context)
            measuresCoreData.extended = extendedIngredietnsCoreData

            let metricCoreData = Metrics(context: context)
            metricCoreData.amount = extendedIngredietns.measures.metric.amount
            metricCoreData.unitLong = extendedIngredietns.measures.metric.unitLong
            metricCoreData.measure = measuresCoreData
        
        }
        do {
            try context.save()
        }
        catch let error {
            print(error)
        }

    }
    
    
    
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        self.viewContainer.bringSubviewToFront(views[sender.selectedSegmentIndex])
    }
    
    @IBAction func saveToFavouriteList(_ sender: Any) {
        saveToCoreData()
        
    }
    
}

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
    let favouriteVC = FavouriteTableViewController()
    let networkService = NetworkRequests()
    var recipe : Recipe?
    var coreDataRecipe : MyFavouriteRecipes?
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
        if coreDataRecipe == nil {
            descriptionView.descriptionOfRecipe = recipe?.summary.trimHTMLTags() ?? "empty"
            if let url = recipe?.image {
                networkService.fetchImage(url) { [weak self] image in
                    guard let self = self else {return}
                    self.imageView.image = image
                }
            }
        } else {
            descriptionView.descriptionOfRecipe = coreDataRecipe?.summary?.trimHTMLTags() ?? "empty"
            guard let data = coreDataRecipe?.image else {return}
            guard let image = UIImage(data: data) else {return}
            self.imageView.image = image
        }

    }
    private func setupIngridientsVC(){
        if coreDataRecipe == nil {
            ingridientsView.recipe = recipe
        } else {
            ingridientsView.coreDataRecipe = coreDataRecipe
        }
        
    }
    private func setupStepsVC(){
        if coreDataRecipe == nil {
            stepsView.recipe = recipe
        } else {
            stepsView.coreDataRecipe = coreDataRecipe
        }
        
    }
    private func start(){
        favouriteVC.callAC(title: "", message: "", style: .alert)
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
        neededRecipe.analyzedInstructions.forEach { analyzedInstruction in
            let analyzedInstructionCoreData = AnalyzedInstructions(context:  context)
            analyzedInstructionCoreData.name = analyzedInstruction.name
            print(analyzedInstruction.name)
            analyzedInstructionCoreData.myRecipe = myRecipe
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
            callmyAc(with: "Done", message: "Recipe was saved", style: .alert, titleButton: "OK", styleButton: .cancel)
        }
        catch  {
            callmyAc(with: "Error", message: "Something happened", style: .alert, titleButton: "OK", styleButton: .cancel)
        }

    }
    
    private func callmyAc(with title : String, message : String?, style : UIAlertController.Style, titleButton : String, styleButton : UIAlertAction.Style){
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: titleButton, style: styleButton, handler: nil)
        ac.addAction(action)
        self.present(ac, animated: true, completion: nil)
    }
    
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        self.viewContainer.bringSubviewToFront(views[sender.selectedSegmentIndex])
    }
    
    @IBAction func saveToFavouriteList(_ sender: Any) {
        saveToCoreData()
        
    }
    
}

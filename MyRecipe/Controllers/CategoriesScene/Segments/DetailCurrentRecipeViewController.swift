//
//  DetailCurrentRecipeViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 14.02.2022.
//

import UIKit

class DetailCurrentRecipeViewController: UIViewController {
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    let descriptionView : UIView = DescriptionViewController().view
    let ingridientsView : UIView = IngridientsTableViewController().view
    let stepsView : UIView = StepsTableViewController().view
    var views : [UIView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        imageView.image = #imageLiteral(resourceName: "lunch")

        
    }
    
    private func setupViews() {
        
        views = [UIView]()
        descriptionView.frame = CGRect(x: 0, y: 0, width: 374, height: 497)
        ingridientsView.frame = CGRect(x: 0, y: 0, width: 374, height: 497)
        stepsView.frame = CGRect(x: 0, y: 0, width: 374, height: 497)
        views.append(descriptionView)
        views.append(ingridientsView)
        views.append(stepsView)
        for view in views {
            viewContainer.addSubview(view)
        }
        viewContainer.bringSubviewToFront(views[0])
    }


    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        self.viewContainer.bringSubviewToFront(views[sender.selectedSegmentIndex])
    }
    
}

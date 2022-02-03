//
//  CategotiesViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 02.02.2022.
//

import UIKit

class CategotiesViewController: UIViewController {

    
    
    @IBOutlet weak var categoriesBackgroundImage: UIImageView!
    @IBOutlet weak var kitchenOne: UIButton!
    @IBOutlet weak var kitcheTwo: UIButton!
    @IBOutlet weak var KitchenFour: UIButton!
    @IBOutlet weak var kitchenThree: UIButton!
    @IBOutlet weak var kitchenFive: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()

    
    }

    
    private func configButtons (_ button : UIButton) -> UIButton {
        
        button.backgroundColor = #colorLiteral(red: 0.3398816586, green: 0.691000104, blue: 0.8087386489, alpha: 1)
        
        button.layer.cornerRadius = button.frame.size.height / 2
        button.clipsToBounds = true
        button.tintColor = .white
        button.titleLabel?.font = UIFont(name: "Baskerville", size: 18)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
            
        switch button.tag {
        case 0 :  button.setTitle("European", for: .normal)
        case 1 :  button.setTitle("Asian", for: .normal)
        case 2 :  button.setTitle("American", for: .normal)
        case 3 :  button.setTitle("Mediterranean", for: .normal)
        case 4 : button.setTitle("Vegeterian", for: .normal)
            
        default:
             button.setTitle("", for: .normal)
        }
        
        return button
        
    }

    private func setupInterface() {
        self.categoriesBackgroundImage.image = #imageLiteral(resourceName: "berries")
        self.configButtons(kitchenOne)
        self.configButtons(kitcheTwo)
        self.configButtons(kitchenThree)
        self.configButtons(KitchenFour)
        self.configButtons(kitchenFive)

        
    }
    func filterRecipes (with recipes : [Recipe], by myCuisine: String) -> [Recipe] {
       return recipes.filter {
           $0.cuisines.contains { cuisine in
               cuisine.lowercased() == myCuisine.lowercased() } }
   }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "euro" :
            if let neededVC = segue.destination as? KitchenTableViewController {
                neededVC.titleKitchenLabel = "europeran"
                neededVC.filterKeyWord = "european"
            }
        case "asian" :
            if let neededVC = segue.destination as? KitchenTableViewController {
                neededVC.titleKitchenLabel = "Chinese"
                neededVC.filterKeyWord = "Chinese"
            }
        case "american" :
            if let neededVC = segue.destination as? KitchenTableViewController {
                neededVC.titleKitchenLabel = "American"
                neededVC.filterKeyWord = "american"
            }
        case  "mediterranean" :
            if let neededVC = segue.destination as? KitchenTableViewController {
                neededVC.titleKitchenLabel = "Mediterranean"
                neededVC.filterKeyWord = "mediterranean"
            }
        default : return
            
        }
    }

}


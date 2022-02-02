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
        case 0 :  button.setTitle("Meditherian", for: .normal)
        case 1 :  button.setTitle("Europian", for: .normal)
        case 2 :  button.setTitle("Caucasian", for: .normal)
        case 3 :  button.setTitle("Russian", for: .normal)
            
        default:
             button.setTitle("", for: .normal)
        }
        
        return button
        
    }
    private func setupInterface() {
        configButtons(kitchenOne)
        configButtons(kitcheTwo)
        configButtons(kitchenThree)
        configButtons(KitchenFour)
    }

    @IBAction func toMedKitchen(_ sender: UIButton) {
    }
    @IBAction func toItalianKitchen(_ sender: Any) {
    }
    @IBAction func toVegetarianKitchen(_ sender: Any) {
    }
    @IBAction func toAsianKitchen(_ sender: Any) {
    }
}

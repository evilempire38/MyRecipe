//
//  DescriptionViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 14.02.2022.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    var descriptionOfRecipe : String = ""

    @IBOutlet weak var descriptionTextField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.descriptionTextField.text = descriptionOfRecipe
        self.descriptionTextField.isEditable = false
        
    }




}

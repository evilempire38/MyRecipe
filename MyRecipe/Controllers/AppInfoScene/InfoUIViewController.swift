//
//  INFOUIViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 25.02.2022.
//

import UIKit

class InfoUIViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "About application"
        label.text = "Created by Andrey Konoplev"


    }
    



}

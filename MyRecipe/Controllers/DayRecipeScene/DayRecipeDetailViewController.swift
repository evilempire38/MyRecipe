//
//  DayRecipeDetailViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 27.01.2022.
//

import UIKit

class DayRecipeDetailViewController: UIViewController {
    var DetailNameVCtitle : String?
    var recipeImageString : String = ""
    var recipeDescriptionString : String = ""
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTextLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = DetailNameVCtitle
         let urlForImage = URL(string: recipeImageString)
        recipeImage.kf.setImage(with: urlForImage)
        recipeTextLabel.text = recipeDescriptionString.trimHTMLTags()
        recipeTextLabel.numberOfLines = 0
    }
    


}

extension String {
    public func trimHTMLTags() -> String? {
        guard let htmlStringData = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue 
        ]
    
        let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
        return attributedString?.string
    }
}

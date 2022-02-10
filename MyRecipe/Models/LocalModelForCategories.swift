//
//  LocalModelForCategories.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 10.02.2022.
//

import Foundation
import UIKit


struct LocalModelForCategories  {
    
    var category : String
    var imageCategory : String
    var image : UIImage {
        let image = UIImage(imageLiteralResourceName: imageCategory)
        return image
    }
    
}

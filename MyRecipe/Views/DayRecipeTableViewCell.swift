//
//  DayRecipeTableViewCell.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 27.01.2022.
//

import UIKit

class DayRecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recipeRating.numberOfLines = 0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

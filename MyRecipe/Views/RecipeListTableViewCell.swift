//
//  KitcheTableViewCell.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 02.02.2022.
//

import UIKit

class RecipeListTableViewCell: UITableViewCell {
    @IBOutlet weak var reciepeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeHealthScore: UILabel!
    @IBOutlet weak var recipeTimeToReady: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

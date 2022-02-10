//
//  CategoriesTableViewCell.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 10.02.2022.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

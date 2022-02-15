//
//  IngridietnsTableViewCell.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 15.02.2022.
//

import UIKit

class IngridietnsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var amountTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

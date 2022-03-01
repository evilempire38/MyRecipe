//
//  ThemeTableViewCell.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 23.02.2022.
//

import UIKit

class ThemeTableViewCell: UITableViewCell {
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var themeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func changeThemeAction(_ sender: UISwitch) {
        switch sender.isOn {
        case true : window?.overrideUserInterfaceStyle = .light
        case false : window?.overrideUserInterfaceStyle = .dark
        }
    }
}

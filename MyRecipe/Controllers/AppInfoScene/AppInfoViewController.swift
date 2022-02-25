//
//  AppInfoViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 23.02.2022.
//

import UIKit

class AppInfoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        registerMyCustomCell()
        configMyTableView()

        

    }
    private func configMyTableView () {
        self.title = "More"
        tableView.tableFooterView = UIView()
        tableView.bounces = false
    }
    
    private func registerMyCustomCell() {
        let themeCell = UINib(nibName: "ThemeTableViewCell", bundle: nil)
        let faqCell = UINib(nibName: "FAQTableViewCell", bundle: nil)
        let contactmeCell = UINib(nibName: "ContactMeTableViewCell", bundle: nil)
        tableView.register(themeCell, forCellReuseIdentifier: "settingsThemeCell")
        tableView.register(faqCell, forCellReuseIdentifier: "settingsFaqCell")
        tableView.register(contactmeCell, forCellReuseIdentifier: "contactMeCell")
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let themeCell = tableView.dequeueReusableCell(withIdentifier: "settingsThemeCell") as! ThemeTableViewCell
            themeCell.themeLabel.text = "App Theme"
            return  themeCell
        } else if indexPath.row == 1 {
            let faqCell = tableView.dequeueReusableCell(withIdentifier: "settingsFaqCell") as! FAQTableViewCell
            faqCell.titleLabel.text = "About application"
            return faqCell
        } else if indexPath.row == 2 {
            let contactMeCell = tableView.dequeueReusableCell(withIdentifier: "contactMeCell") as! ContactMeTableViewCell
            contactMeCell.contactmeLabel.text = "Contact me!"
            return contactMeCell
        } else {
            return UITableViewCell()
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            performSegue(withIdentifier: "faq", sender: self)
        }
    }
 
    
}


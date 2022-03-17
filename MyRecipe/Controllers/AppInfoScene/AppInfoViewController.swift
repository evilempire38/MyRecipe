//
//  AppInfoViewController.swift
//  MyRecipe
//
//  Created by Андрей Коноплёв on 23.02.2022.
//

import UIKit
import MessageUI

final class AppInfoTableViewController: UITableViewController {

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
        } else if indexPath.row == 2 {
            showMailComposer()
        }
    }
 
    
}
extension AppInfoTableViewController : MFMailComposeViewControllerDelegate {
   func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
         if let _ = error {
             controller.dismiss(animated: true, completion: nil)
             return
         }
         switch result {
         case .cancelled:
             break
         case .failed:
             break
         case .saved:
             break
         case .sent:
             break
         default : break
         }
         controller.dismiss(animated: true, completion: nil)
     }
    private func showMailComposer() {
        guard MFMailComposeViewController.canSendMail() else {return}
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["evilempire38@gmail.com"])
        composer.setSubject("MyRecipe issues")
        composer.setMessageBody("Hello, Andrey! I have some issue :", isHTML: false)
        present(composer, animated: true, completion: nil)
    }
    
}


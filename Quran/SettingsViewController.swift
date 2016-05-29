//
//  SettingsViewController.swift
//  Quran
//
//  Created by Mohamed Afifi on 4/19/16.
//  Copyright © 2016 Quran.com. All rights reserved.
//

import UIKit

class SettingsViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.secondaryColor()
        title = navigationController?.tabBarItem.title
    }
}

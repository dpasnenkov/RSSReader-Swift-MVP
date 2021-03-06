//
//  SettingsViewController.swift
//  RSSReader
//
//  Created by Dmitry Pasnenkov on 4/6/20.
//  Copyright © 2020 Dmitry Pasnenkov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var presenter: SettingPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SettingPresenter(view: self)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController: SettingView {
    
}

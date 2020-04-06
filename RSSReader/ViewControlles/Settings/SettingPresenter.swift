//
//  SettingPresenter.swift
//  RSSReader
//
//  Created by Dmitry Pasnenkov on 4/6/20.
//  Copyright © 2020 Dmitry Pasnenkov. All rights reserved.
//

import UIKit

protocol SettingView: class {
    
}

class SettingPresenter: NSObject {

    weak var view: SettingView?
    
    init(view: SettingView) {
        self.view = view
        
        super.init()
    }
    
}

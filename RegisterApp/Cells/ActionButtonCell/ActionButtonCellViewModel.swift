//
//  ActionButtonCellViewModel.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import Foundation

class ActionButtonCellViewModel:BaseViewModel{
    
    var buttonName:String = "" {
        didSet{
            changeButtonName?()
        }
    }
    
    var changeButtonName:(()->())?
    
    var buttonAction:(()->())?
    
    init(buttonName:String, buttonAction:@escaping (()->())){
        self.buttonName = buttonName
        self.buttonAction = buttonAction
    }
}

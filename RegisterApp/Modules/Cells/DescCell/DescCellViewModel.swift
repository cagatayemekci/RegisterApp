//
//  DescCellViewModel.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import Foundation

class DescCellViewModel :BaseViewModel{
    
    var descText:String = "" {
        didSet{
            descTextChanged?()
        }
    }
    
    var descTextChanged:(()->())?
    
    init(_ descText: String){
        self.descText = descText
    }
}

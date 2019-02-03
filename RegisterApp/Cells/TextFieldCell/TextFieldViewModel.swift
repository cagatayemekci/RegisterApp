//
//  TextFieldViewModel.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import Foundation

class TextFieldViewModel:BaseViewModel {
    
    var textFieldText:String = "" {
        didSet{
            textFieldTextChanged?()
        }
    }
    
    var validDataState:Bool = false {
        didSet{
            validDataStateChange?(validDataState)
        }
    }
    
    var textFieldTextChanged:(()->())?
    var validDataStateChange:((_ state:Bool)->())?
    
    var isValidDataClosure:((_ text:String)->Bool)?
    var setRegisterModel:(()->())?
    init(type:RegisterScreenCellTypeEnum, isValidDataClosure:@escaping ((_ text:String)->Bool)){
        super.init()
        self.isValidDataClosure = isValidDataClosure
        self.type = type
    }
}

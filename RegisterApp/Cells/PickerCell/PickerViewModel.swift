//
//  PickerViewModel.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 3.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import Foundation

class PickerViewModel:BaseViewModel {
    var pickerDatas:[String] = [String]() {
        didSet{
            pickerViewReload?()
        }
    }
    
    var pickerSelectedData:String = "" {
        didSet{
            textFieldUpdate?()
        }
    }
    
    var pickerViewReload:(()->())?
    var textFieldUpdate:(()->())?
    
    var numberOfCells: Int {
        return pickerDatas.count
    }
    
    init(pickerDatas:[String]) {
        self.pickerDatas = pickerDatas
    }
}

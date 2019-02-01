//
//  BaseViewModel.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import Foundation

enum RegisterScreenCellTypeEnum: String, CaseIterable {
    
    case appDesc = "appDesc"
    case firstName = "firstName"
    case surName = "surName"
    
    static let allValues = RegisterScreenCellTypeEnum.allCases.map { $0.rawValue }
}

class BaseViewModel {
    var type:RegisterScreenCellTypeEnum?
}

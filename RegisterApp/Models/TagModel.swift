//
//  TagModel.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 3.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import Foundation

struct TagModel {
    var name:String?
    var isSelected:Bool?
    init(name:String,isSelected:Bool) {
        self.isSelected = isSelected
        self.name = name
    }
}

extension TagModel :Equatable {
    static func == (lhs: TagModel, rhs: TagModel) -> Bool {
        return lhs.name == rhs.name
    }
}

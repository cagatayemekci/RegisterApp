//
//  TagCollectionCellViewModel.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import Foundation

class TagCollectionCellViewModel:BaseCollectionCellViewModel {
    
    var tagModel:TagModel? = nil {
        didSet{
            tagText = tagModel?.name
            isSelected = tagModel?.isSelected
        }
    }
    
    var tagText:String? = "" {
        didSet{
            tagTextChange?(tagText ?? "")
        }
    }
    
    var isSelected:Bool? = false {
        didSet{
            isSelectedChange?(isSelected ?? false)
        }
    }
    
    var tagTextChange:((String)->())?
    var isSelectedChange:((Bool)->())?
    
    init(tagModel:TagModel) {
        self.tagModel = tagModel
    }
}


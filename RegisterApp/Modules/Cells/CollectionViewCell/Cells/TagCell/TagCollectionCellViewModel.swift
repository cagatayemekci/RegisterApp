//
//  TagCollectionCellViewModel.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import Foundation

class TagCollectionCellViewModel:BaseCollectionCellViewModel {
    
    var tagText:String? = "" {
        didSet{
            tagTextChange?()
        }
    }
    
    var tagTextChange:(()->())?
    
    init(tagText:String) {
        self.tagText = tagText
    }
}


//
//  AddTagCollectionCellViewModel.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 2.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import Foundation

class AddCollectionCellViewModel:BaseCollectionCellViewModel {
    
    var addTagText:String? = "" {
        didSet{
            addTagTextChange?()
        }
    }
    
    var addTagTextChange:(()->())?
    init(addTagText:String) {
        self.addTagText = addTagText
    }
}

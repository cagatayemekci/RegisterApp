//
//  CollectionViewCellModel.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import Foundation

class CollectionViewCellModel:BaseViewModel {
    
    var tagModels:[TagCollectionCellViewModel] = [TagCollectionCellViewModel]() {
        didSet{
            collectionViewReload?()
        }
    }
    
    var numberOfCells: Int {
        return tagModels.count
    }
    
    var collectionViewReload:(()->())?
    
    init(tagModels:[TagCollectionCellViewModel]){
        self.tagModels = tagModels
    }
    
}

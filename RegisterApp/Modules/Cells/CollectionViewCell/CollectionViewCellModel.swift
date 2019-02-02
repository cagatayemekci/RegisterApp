//
//  CollectionViewCellModel.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import Foundation

class CollectionViewCellModel:BaseViewModel {
    
    var tagModels:[BaseCollectionCellViewModel] = [BaseCollectionCellViewModel]() {
        didSet{
            collectionViewReload?()
        }
    }
    
    var numberOfCells: Int {
        return tagModels.count
    }
    
    var collectionViewReload:(()->())?
    
    init(tagModels:[BaseCollectionCellViewModel]){
        self.tagModels = tagModels
    }
    
    
    func cellIdentifier(for viewModel: BaseCollectionCellViewModel) -> String {
        switch viewModel {
        case is AddCollectionCellViewModel:
            return AddTagCollectionViewCell.cellIdentifier()
        case is TagCollectionCellViewModel:
            return TagCollectionViewCell.cellIdentifier()
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
    }
}

//
//  SkillsViewModel.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 2.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import Foundation

class SkillsViewModel {
    
    var tagModels:[BaseCollectionCellViewModel] = [BaseCollectionCellViewModel]() {
        didSet{
            collectionViewReload?()
        }
    }
    
    var selectedTags:[String] = {
        return [String]()
    }()
    
    var numberOfCells: Int {
        return tagModels.count
    }
    
    var collectionViewReload:(()->())?
    var addedTags:(()->())?
    
    func addTags(tag:String){
        selectedTags.append(tag)
        addedTags?()
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
    
    func createTagModels(){
        var tags = [BaseCollectionCellViewModel]()
        tags.append(TagCollectionCellViewModel(tagText: "Communication"))
        tags.append(TagCollectionCellViewModel(tagText: "Teamwork"))
        tags.append(TagCollectionCellViewModel(tagText: "Creativity"))
        tags.append(TagCollectionCellViewModel(tagText: "Leadership"))
        tags.append(TagCollectionCellViewModel(tagText: "Time Management"))
        tags.append(TagCollectionCellViewModel(tagText: "Decision Making"))
        tags.append(TagCollectionCellViewModel(tagText: "Self-motivation"))
        tags.append(TagCollectionCellViewModel(tagText: "Conflict Resolution"))
        tags.append(TagCollectionCellViewModel(tagText: "Adaptability"))
        tags.append(TagCollectionCellViewModel(tagText: "Ability to Work Under Pressure"))
        tagModels = tags
    }
}

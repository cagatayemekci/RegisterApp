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
    
    var selectedTags:[TagModel] = {
        return [TagModel]()
    }()
    
    var numberOfCells: Int {
        return tagModels.count
    }
    
    var collectionViewReload:(()->())?
    var addedTags:(()->())?
    
    func addTags(tag:TagModel){
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

        tags.append(TagCollectionCellViewModel(tagModel: TagModel(name: "Communication", isSelected: false)))
        tags.append(TagCollectionCellViewModel( tagModel: TagModel(name: "Teamwork", isSelected: false)))
        tags.append(TagCollectionCellViewModel(tagModel: TagModel(name: "Creativity", isSelected: false)))
        tags.append(TagCollectionCellViewModel(tagModel: TagModel(name: "Leadership", isSelected: false)))
        
        tags.append(TagCollectionCellViewModel(tagModel: TagModel(name: "Time Management", isSelected: false)))
        tags.append(TagCollectionCellViewModel(tagModel: TagModel(name: "Decision Making", isSelected: false)))
        tags.append(TagCollectionCellViewModel(tagModel: TagModel(name: "Self-motivation", isSelected: false)))
        tags.append(TagCollectionCellViewModel(tagModel: TagModel(name: "Conflict Resolution", isSelected: false)))
        tags.append(TagCollectionCellViewModel(tagModel: TagModel(name: "Adaptability", isSelected: false)))
        tagModels = tags
    }
}

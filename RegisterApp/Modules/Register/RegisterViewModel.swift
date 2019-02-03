//
//  RegisterViewModel.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import Foundation

class RegisterViewModel {
    var vModelArray:[BaseViewModel] = [BaseViewModel]() {
        didSet {
            tableVeiewReload?()
        }
    }
    
    var tagsArr:[TagModel] = [TagModel]() {
        didSet {
           createModelArray()
        }
    }
    
    lazy var registerModel : RegisterModel = {
        return RegisterModel()
    }()
    
    var tableVeiewReload:(()->())?
    var showSkillsComponent:(()->())?
    var endEditing:(()->())?
    var showMessage:((String)->())?
    
    func createModelArray(){
        var modelArray:[BaseViewModel] = [BaseViewModel]()
        let image = ImageCellViewModel("backimage")
        let descAppVM = DescCellViewModel("Welcome to Register App")
        let skillsVM = DescCellViewModel("Skills")
        let descFirtNameVM = DescCellViewModel("Fist Name ")
        let firstNameTextFieldVM = TextFieldViewModel(type: .firstName,isValidDataClosure: isValidTextFistName)
        firstNameTextFieldVM.setRegisterModel = setRegisterModel(viewModel: firstNameTextFieldVM)
        let descSurNameVM = DescCellViewModel("SurName")
        let surNameTextFieldVM = TextFieldViewModel(type:.surName ,isValidDataClosure: isValidTextSurName)
        surNameTextFieldVM.setRegisterModel = setRegisterModel(viewModel: surNameTextFieldVM)
        let actionButton = ActionButtonCellViewModel(buttonName: "Tamam", buttonAction:buttonAction)
        
        let tag = CollectionViewCellModel(tagModels: createTagModels(tags: tagsArr))
        
        let picker = PickerViewModel(pickerDatas: ["1","2","3","1"])
        modelArray.append(image)
        modelArray.append(descAppVM)
        modelArray.append(descFirtNameVM)
        modelArray.append(firstNameTextFieldVM)
        modelArray.append(descSurNameVM)
        modelArray.append(surNameTextFieldVM)
        modelArray.append(skillsVM)
        modelArray.append(tag)
        modelArray.append(actionButton)
        modelArray.append(picker)
        vModelArray = modelArray
    } 
    
    fileprivate func setRegisterModel(viewModel :BaseViewModel) -> (() -> Void) {
        return { [weak self, weak viewModel] in
            guard let self = self else {return}
            guard let vModel = viewModel as? TextFieldViewModel else {return}
            switch vModel.type {
            case .firstName?:
                self.registerModel.firstName = vModel.textFieldText
                break
            case .surName?:
                self.registerModel.surName = vModel.textFieldText
                break
            default: break
            }
        }
    }
    
    lazy var isValidTextFistName: ((_ text:String)->Bool) = { text in
        if text.count > 5 {
            return true
        }
        return false
    }
    
    lazy var isValidTextSurName: ((_ text:String)->Bool) = { text in
        if text.count > 10 {
            return true
        }
        return false
    }
    
    lazy var buttonAction: (()->()) = {[weak self] () in
        guard let self = self else {return}
        self.endEditing?()
        if let msg = self.registerModel.getErrorMessage(){
            self.showMessage?(msg)
        }else{
            self.showMessage?(self.registerModel.fullName)
        }
    }
    
    var numberOfCells: Int {
        return vModelArray.count
    }
    
    func cellIdentifier(for viewModel: BaseViewModel) -> String {
        switch viewModel {
        case is TextFieldViewModel:
            return TextFieldTableViewCell.cellIdentifier()
        case is DescCellViewModel:
            return DescTableViewCell.cellIdentifier()
        case is ActionButtonCellViewModel:
            return ActionButtonTableViewCell.cellIdentifier()
        case is CollectionViewCellModel:
            return CollectionViewTableViewCell.cellIdentifier()
        case is ImageCellViewModel:
            return ImageTableViewCell.cellIdentifier()
        case is PickerViewModel:
            return PickerTableViewCell.cellIdentifier()
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
    }
    
    lazy var cellPressed:(()->())  = { [weak self] () in
        guard let self = self else {return}
        self.showSkillsComponent?()
    }
    
    func createTagModels(tags:[TagModel]) -> [BaseCollectionCellViewModel]{
        var baseCollectionCellViewModel = [BaseCollectionCellViewModel]()
        for tag in tags {
            baseCollectionCellViewModel.append(TagCollectionCellViewModel(tagModel: tag))
        }
        let addTagVM = AddCollectionCellViewModel(addTagText: "Add +")
        addTagVM.cellPressed = cellPressed
        baseCollectionCellViewModel.append(addTagVM)
        return baseCollectionCellViewModel
    }
}


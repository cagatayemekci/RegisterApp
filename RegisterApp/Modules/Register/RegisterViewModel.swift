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
    
    lazy var registerModel : RegisterModel = {
        return RegisterModel()
    }()
    
    var tableVeiewReload:(()->())?
    var endEditing:(()->())?
    var showMessage:((String)->())?
    
    func createModelArray(){
        var modelArray:[BaseViewModel] = [BaseViewModel]()
        let descAppVM = DescCellViewModel("User Name asşdak şalskdşalskd aşlsdk asd asdk aşsldk aşlsdk aşlsd kaşlkd aşldk ashdaşsdk aşlsdk asşldk asşld kasşldk aşld kaşld kalşsd kaşld asşldkaşls aldkaşsldk aşlsdkaşlsdk aşlkd aşlsdk aşlsdk aşlsd kaşlsd kaşlsd kaşls dkaşldkaşld kasşld kasşld kaşsld kaşld kaşld kasşld kaşlsd kaşld kqwkdp qwk dopqdk qopd kqpowdk q dasişd laisşdl aişsdl aişsdl aişsdl aişsd laisşdl aişsdl aişsdl aisşdl aişsdl aisşdl asişdl aişdl aidsşl asişdl aid aşl sd ialşdişaldaişl aişdl aişdl aişdl ")
        let descFirtNameVM = DescCellViewModel("Fist Name ")
        let firstNameTextFieldVM = TextFieldViewModel(type: .firstName,isValidDataClosure: isValidTextFistName)
        firstNameTextFieldVM.setRegisterModel = setRegisterModel(viewModel: firstNameTextFieldVM)
        let descSurNameVM = DescCellViewModel("SurName")
        let surNameTextFieldVM = TextFieldViewModel(type:.surName ,isValidDataClosure: isValidTextSurName)
        surNameTextFieldVM.setRegisterModel = setRegisterModel(viewModel: surNameTextFieldVM)
        let actionButton = ActionButtonCellViewModel(buttonName: "Tamam", buttonAction:buttonAction)
        
        let tag = CollectionViewCellModel(tagModels: createTagModels())
        
        modelArray.append(descAppVM)
        modelArray.append(descFirtNameVM)
        modelArray.append(firstNameTextFieldVM)
        modelArray.append(descSurNameVM)
        modelArray.append(surNameTextFieldVM)
        modelArray.append(actionButton)
        modelArray.append(tag)
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
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
    }
    
    
    func createTagModels() -> [TagCollectionCellViewModel]{
        var tags = [TagCollectionCellViewModel]()
        let tagModel = TagCollectionCellViewModel(tagText: "Spor")
        let tagModel1 = TagCollectionCellViewModel(tagText: "Eğlence")
        let tagModel2 = TagCollectionCellViewModel(tagText: "İş Hayatı")
        let tagModel3 = TagCollectionCellViewModel(tagText: "Dans")
        tags.append(tagModel)
        tags.append(tagModel1)
        tags.append(tagModel2)
        tags.append(tagModel3)
        tags.append(TagCollectionCellViewModel(tagText: "Gezi"))
        tags.append(TagCollectionCellViewModel(tagText: "Dağcılık"))
        tags.append(TagCollectionCellViewModel(tagText: "Yürüyüş"))
        return tags
    }
}


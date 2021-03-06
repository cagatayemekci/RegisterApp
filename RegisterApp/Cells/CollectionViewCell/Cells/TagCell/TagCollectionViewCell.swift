//
//  TagCollectionViewCell.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import UIKit

class TagCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    var tagColletionVModel:TagCollectionCellViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBackView()
        // Initialization code
    }
    
    fileprivate func setupBackView(){
        backView.layer.borderWidth = 1
        backView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        backView.layer.cornerRadius = 5
        backView.layer.masksToBounds = true
    }
    
    override func setup(viewModel: BaseCollectionCellViewModel) {
        guard let vModel = viewModel as? TagCollectionCellViewModel else {return}
        vModel.tagTextChange = {[weak self] tagText in
            guard  let self = self else {
                return
            }
            self.tagLabel.text = tagText
        }
        
        vModel.cellPressed = {[weak self] in
            guard  let self = self else {
                return
            }
            self.tagLabel.textColor = #colorLiteral(red: 0.9996010661, green: 0.4771931171, blue: 0.4261316061, alpha: 1)
        }
        
        vModel.isSelectedChange = {[weak self] selected in
            guard  let self = self else {
                return
            }
            if selected {
                self.tagLabel.textColor = #colorLiteral(red: 0.9996010661, green: 0.4771931171, blue: 0.4261316061, alpha: 1)
            }else{
                self.tagLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
         tagColletionVModel = vModel
         tagColletionVModel?.tagModel = vModel.tagModel
    }
}

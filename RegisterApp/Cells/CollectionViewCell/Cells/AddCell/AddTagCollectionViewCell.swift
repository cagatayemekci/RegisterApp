//
//  AddTagCollectionViewCell.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 2.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import UIKit

class AddTagCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var addTagLabel: UILabel!
    var addTagCellViewModel:AddCollectionCellViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
          setupBackView()
        // Initialization code
    }

    fileprivate func setupBackView(){
        backView.layer.borderWidth = 1
        backView.layer.borderColor = #colorLiteral(red: 0.9996010661, green: 0.4771931171, blue: 0.4261316061, alpha: 1)
        backView.layer.cornerRadius = 5
        backView.layer.masksToBounds = true
    }
    
    override func setup(viewModel: BaseCollectionCellViewModel) {
        guard let vModel = viewModel as? AddCollectionCellViewModel else {return}
        self.addTagLabel.text = vModel.addTagText
        vModel.addTagTextChange = {[weak self] in
            guard  let self = self else {
                return
            }
            self.addTagLabel.text = vModel.addTagText
        }
        addTagCellViewModel = vModel
    }
    
}

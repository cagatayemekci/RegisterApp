//
//  TagCollectionViewCell.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import UIKit

class TagCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var tagLabel: UILabel!    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setup(viewModel: BaseCollectionCellViewModel) {
        guard let vModel = viewModel as? TagCollectionCellViewModel else {return}
        self.tagLabel.text = vModel.tagText
        vModel.tagTextChange = {[weak self] in
            guard  let self = self else {
                return
            }
            self.tagLabel.text = vModel.tagText
        }
    }
}

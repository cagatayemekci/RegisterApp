//
//  DescTableViewCell.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import UIKit

class DescTableViewCell: BaseTableViewCell {

    
    @IBOutlet weak var descLabel: UILabel!
    
    var descCellViewModel:DescCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setup(viewModel: BaseViewModel) {
        guard let vModel = viewModel as? DescCellViewModel else {
            return
        }
        descCellViewModel = vModel
        self.descLabel.text = descCellViewModel?.descText
        setupVM()
    }
    
    fileprivate func setupVM() {
        descCellViewModel?.descTextChanged = { [weak self] in
            guard let self = self else {return}
            self.descLabel.text = self.descCellViewModel?.descText
        }
    }
    
}

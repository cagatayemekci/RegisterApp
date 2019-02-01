//
//  ActionButtonTableViewCell.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import UIKit

class ActionButtonTableViewCell: BaseTableViewCell {

    @IBOutlet weak var actionButton: UIButton!
    var actionButtonViewModel: ActionButtonCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setup(viewModel: BaseViewModel) {
        guard let vModel = viewModel as? ActionButtonCellViewModel else {return}
        self.actionButtonViewModel = vModel
        self.actionButton.setTitle(vModel.buttonName, for: .normal)
        setupVM()
    }
    
    fileprivate func setupVM(){}
    
    @IBAction func actionButtonTapped(_ sender: Any) {
         actionButtonViewModel?.buttonAction?()
    }
}

//
//  BaseTableViewCell.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import UIKit

protocol BaseCellProtocol {
    func setup(viewModel: BaseViewModel)
}
class BaseTableViewCell: UITableViewCell,BaseCellProtocol {
    
    func setup(viewModel: BaseViewModel) {}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension UITableViewCell {
    /// Generated cell identifier derived from class name
    public static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

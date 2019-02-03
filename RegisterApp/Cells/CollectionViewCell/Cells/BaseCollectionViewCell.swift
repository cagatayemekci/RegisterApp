//
//  BaseCollectionViewCell.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import UIKit

protocol BaseCollectionCellProtocol{
     func setup(viewModel: BaseCollectionCellViewModel)
}

class BaseCollectionViewCell: UICollectionViewCell, BaseCollectionCellProtocol{
    func setup(viewModel: BaseCollectionCellViewModel) { }
}



extension UICollectionViewCell {
    /// Generated cell identifier derived from class name
    public static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

//
//  ImageTableViewCell.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 2.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import UIKit

class ImageTableViewCell: BaseTableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    
    var imageCellViewModel:ImageCellViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setup(viewModel: BaseViewModel) {
        guard let vModel = viewModel as? ImageCellViewModel else {
            return
        }
        imageCellViewModel = vModel
        self.cellImageView.image = UIImage.init(named: imageCellViewModel?.imageName ?? "")
        
        setupVM()
    }
    
    fileprivate func setupVM() {
        imageCellViewModel?.imageNameChanged = { [weak self] () in
            guard let self = self else {return}
            self.cellImageView.image = UIImage.init(named: self.imageCellViewModel?.imageName ?? "")
        }
    }
    
}

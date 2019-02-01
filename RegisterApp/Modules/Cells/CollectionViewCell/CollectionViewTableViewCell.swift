//
//  CollectionViewTableViewCell.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import UIKit

class CollectionViewTableViewCell: BaseTableViewCell {

    @IBOutlet weak var heightConst: NSLayoutConstraint!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    var collectionViewViewModel:CollectionViewCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagCollectionView.register(UINib(nibName: "TagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagCollectionViewCell")
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        // Initialization code
    }
    
    fileprivate func setupVM() {
        collectionViewViewModel?.collectionViewReload = { [weak self] in
            guard let self = self else {return}
            self.layoutIfNeeded()
            self.setNeedsLayout()
            self.tagCollectionView.reloadData()
            
        }
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.heightConst.constant = self.tagCollectionView.contentSize.height;
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setup(viewModel: BaseViewModel) {
        guard let vModel = viewModel as? CollectionViewCellModel else {return}
        self.collectionViewViewModel = vModel
        setupVM()
        self.collectionViewViewModel?.tagModels = vModel.tagModels
        
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewViewModel?.numberOfCells ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let rowViewModel = collectionViewViewModel?.tagModels[indexPath.row] else {return UICollectionViewCell()}
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath as IndexPath) as! TagCollectionViewCell
        if let cell = cell as? BaseCollectionViewCell {
            cell.setup(viewModel: rowViewModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
}

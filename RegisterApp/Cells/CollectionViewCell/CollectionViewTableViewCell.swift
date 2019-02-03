//
//  CollectionViewTableViewCell.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import UIKit

class CollectionViewTableViewCell: BaseTableViewCell {

    @IBOutlet weak var widthConst: NSLayoutConstraint!
    @IBOutlet weak var heightConst: NSLayoutConstraint!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    var collectionViewViewModel:CollectionViewCellModel?
    let columnLayout = FlowLayout(
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )
    override func awakeFromNib() {
        super.awakeFromNib()
        tagCollectionView.register(UINib(nibName: "TagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagCollectionViewCell")
        tagCollectionView.register(UINib(nibName: "AddTagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddTagCollectionViewCell")
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView?.collectionViewLayout = columnLayout
        tagCollectionView?.contentInsetAdjustmentBehavior = .always
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
        self.widthConst.constant = self.tagCollectionView.contentSize.width;
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
        let cellId = collectionViewViewModel?.cellIdentifier(for: rowViewModel)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId ?? "", for: indexPath as IndexPath)
        if let cell = cell as? BaseCollectionViewCell {
            cell.setup(viewModel: rowViewModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
        let rowViewModel = collectionViewViewModel?.tagModels[indexPath.row]
        if let model = rowViewModel as? TagCollectionCellViewModel{
            model.tagModel?.isSelected = true
        }else{
            rowViewModel?.cellPressed?()
        }
        
    }
}

class FlowLayout: UICollectionViewFlowLayout {
    
    required init(minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        super.init()
        
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
        sectionInsetReference = .fromSafeArea
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        guard scrollDirection == .vertical else { return layoutAttributes }
        
        // Filter attributes to compute only cell attributes
        let cellAttributes = layoutAttributes.filter({ $0.representedElementCategory == .cell })
        
        // Group cell attributes by row (cells with same vertical center) and loop on those groups
        for (_, attributes) in Dictionary(grouping: cellAttributes, by: { ($0.center.y / 10).rounded(.up) * 10 }) {
            // Set the initial left inset
            var leftInset = sectionInset.left
            
            // Loop on cells to adjust each cell's origin and prepare leftInset for the next cell
            for attribute in attributes {
                attribute.frame.origin.x = leftInset
                leftInset = attribute.frame.maxX + minimumInteritemSpacing
            }
        }
        
        return layoutAttributes
    }
    
}

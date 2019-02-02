//
//  SkillsViewController.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 2.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import UIKit

protocol SkillsViewControllerDelegate{
    func updateSkillsArray(array:[String])
}

class SkillsViewController: UIViewController {

    @IBOutlet weak var skillCollectionView: UICollectionView!
    lazy var skillsViewModel: SkillsViewModel = {
        return SkillsViewModel()
    }()
     @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var delegate:SkillsViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        skillCollectionView.register(UINib(nibName: "TagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagCollectionViewCell")
        skillCollectionView.delegate = self
        skillCollectionView.dataSource = self
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        skillsViewModel.createTagModels()
        skillsViewModel.collectionViewReload = {[weak self] () in
            guard let self = self else {
                return
            }
            self.loadViewIfNeeded()
            self.skillCollectionView.reloadData()
        }
        skillsViewModel.addedTags = {[weak self] () in
                guard let self = self else {
                    return
                }
            self.delegate?.updateSkillsArray(array: self.skillsViewModel.selectedTags)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.skillCollectionView.reloadData()
    }
    

}

extension SkillsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skillsViewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rowViewModel = skillsViewModel.tagModels[indexPath.row]
        let cellId = skillsViewModel.cellIdentifier(for: rowViewModel)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId , for: indexPath as IndexPath)
        if let cell = cell as? BaseCollectionViewCell {
            cell.setup(viewModel: rowViewModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
        guard let rowViewModel = skillsViewModel.tagModels[indexPath.row] as? TagCollectionCellViewModel else {return}
        if let text = rowViewModel.tagText {
            skillsViewModel.addTags(tag: text)
        }
    }
}


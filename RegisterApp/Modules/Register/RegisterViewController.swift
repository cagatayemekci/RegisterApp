//
//  ViewController.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var registerTableView: UITableView!
    
    lazy var registerViewModel: RegisterViewModel = {
        return RegisterViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView.estimatedRowHeight = 85.0
        registerTableView.rowHeight = UITableView.automaticDimension
        registerTableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "TextFieldTableViewCell")
        registerTableView.register(UINib(nibName: "DescTableViewCell", bundle: nil), forCellReuseIdentifier: "DescTableViewCell")
        registerTableView.register(UINib(nibName: "ActionButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "ActionButtonTableViewCell")
        registerTableView.register(UINib(nibName: "CollectionViewTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionViewTableViewCell")
        setupVM()
        registerViewModel.createModelArray()
    }
    
    fileprivate func setupVM() {
        // Do any additional setup after loading the view, typically from a nib.
        registerViewModel.tableVeiewReload = {[weak self] in
            guard let self = self else {return}
            self.registerTableView.reloadData()
        }
        
        registerViewModel.endEditing = {[weak self] in
            guard let self = self else {return}
            self.view.endEditing(true)
        }
        
        registerViewModel.showMessage = {[weak self] msg in
            guard let self = self else {return}
            self.showAlert(title:"",msg: msg)
        }
    }
    
    fileprivate func showAlert(title:String, msg:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            print("Okay'd")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension RegisterViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registerViewModel.vModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowViewModel = registerViewModel.vModelArray[indexPath.row]
        let cellId = registerViewModel.cellIdentifier(for: rowViewModel)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if let cell = cell as? BaseTableViewCell {
            cell.setup(viewModel: rowViewModel)
        }
        cell.layoutIfNeeded()
        return cell
    }
    
    
}


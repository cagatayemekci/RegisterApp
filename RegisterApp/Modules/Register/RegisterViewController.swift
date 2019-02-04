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
    
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var container: UIView!
    lazy var registerViewModel: RegisterViewModel = {
        return RegisterViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView.estimatedRowHeight = 85.0
        registerTableView.rowHeight = UITableView.automaticDimension
        registerTableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: TextFieldTableViewCell.cellIdentifier())
        registerTableView.register(UINib(nibName: "DescTableViewCell", bundle: nil), forCellReuseIdentifier: DescTableViewCell.cellIdentifier())
        registerTableView.register(UINib(nibName: "ActionButtonTableViewCell", bundle: nil), forCellReuseIdentifier: ActionButtonTableViewCell.cellIdentifier())
        registerTableView.register(UINib(nibName: "CollectionViewTableViewCell", bundle: nil), forCellReuseIdentifier: CollectionViewTableViewCell.cellIdentifier())
        registerTableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: ImageTableViewCell.cellIdentifier())
        registerTableView.register(UINib(nibName: "PickerTableViewCell", bundle: nil), forCellReuseIdentifier: PickerTableViewCell.cellIdentifier())
        setupSkillsViewController()
        setupVM()
        registerViewModel.createModelArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func setupVM() {
        // Do any additional setup after loading the view, typically from a nib.
        registerViewModel.tableVeiewReload = {[weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.registerTableView.reloadData()
            }
            
        }
        
        registerViewModel.endEditing = {[weak self] in
            guard let self = self else {return}
            self.view.endEditing(true)
        }
        
        registerViewModel.showMessage = {[weak self] msg in
            guard let self = self else {return}
            self.showAlert(title:"",msg: msg)
        }
        
        registerViewModel.showSkillsComponent =  {[weak self] () in
            guard let self = self else {return}
            let swipeGesture = UISwipeGestureRecognizer()
            swipeGesture.direction = .up
            self.handleGesture(gesture: swipeGesture)
        }
    }
    
    fileprivate func showAlert(title:String, msg:String){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                print("Okay'd")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension RegisterViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registerViewModel.numberOfCells
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


extension RegisterViewController {
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            registerTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.2, animations: {
            // For some reason adding inset in keyboardWillShow is animated by itself but removing is not, that's why we have to use animateWithDuration here
            self.registerTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        })
    }
}

extension RegisterViewController {
    func setupSkillsViewController(){
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeUp.direction = .up
        container.addGestureRecognizer(swipeUp)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let addViewController = storyboard.instantiateViewController(withIdentifier: "SkillsViewController") as? SkillsViewController else {return}
        addViewController.didMove(toParent: self)
        self.addChild(addViewController)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "conteinerId"){
            let embedVC = segue.destination as! SkillsViewController
            embedVC.delegate = self
        }
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.up {
            print("Swipe Up")
            self.containerViewBottomConstraint.constant = 0
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
        if gesture.direction == UISwipeGestureRecognizer.Direction.down {
            self.containerViewBottomConstraint.constant = -220
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            
        }
    }
}

extension RegisterViewController:SkillsViewControllerDelegate{
    func updateSkillsArray(array: [TagModel]) {
        registerViewModel.tagsArr = array
    }
}

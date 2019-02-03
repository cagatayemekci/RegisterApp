//
//  PickerTableViewCell.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 3.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import UIKit

class PickerTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var pickerTextField: UITextField!
    var pickerViewModel:PickerViewModel?
    lazy var pickerView:UIPickerView = {
        let dayPicker = UIPickerView()
        dayPicker.delegate = self
        pickerTextField.inputView = dayPicker
        return dayPicker
    }()
    
    lazy var toolbar:UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerTextField.inputAccessoryView = toolbar
    }
    
    override func setup(viewModel: BaseViewModel) {
        guard let vModel = viewModel as? PickerViewModel else {return}
        self.pickerViewModel = vModel
        setupVM()
        pickerViewModel?.pickerDatas = vModel.pickerDatas
    }
    
    fileprivate func setupVM(){
        pickerViewModel?.pickerViewReload = {[weak self] in
            guard let self = self else {return}
            self.pickerView.reloadInputViews()
            self.pickerView.reloadAllComponents()
        }
        pickerViewModel?.textFieldUpdate = {[weak self] in
            guard let self = self else {return}
            self.pickerTextField.text = self.pickerViewModel?.pickerSelectedData
        }
    }
    
    @objc func dismissKeyboard() {
        contentView.endEditing(true)
    }
}

extension PickerTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewModel?.numberOfCells ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewModel?.pickerDatas[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerViewModel?.pickerSelectedData = pickerViewModel?.pickerDatas[row] ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Menlo-Regular", size: 17)
        label.text = pickerViewModel?.pickerDatas[row]
        return label
    }
}

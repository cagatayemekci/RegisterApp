//
//  TextFieldTableViewCell.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: BaseTableViewCell,UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var validDataStateImageView: UIImageView!
    var textFieldViewModel: TextFieldViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setup(viewModel: BaseViewModel) {
        guard let vModel = viewModel as? TextFieldViewModel else {return}
        self.textFieldViewModel = vModel
        setupVM()
    }
    
    fileprivate func setupVM() {
        textFieldViewModel?.textFieldTextChanged = {[weak self] () in
            guard let self = self else {return}
            guard let text = self.textFieldViewModel?.textFieldText else {return}
            self.textFieldViewModel?.validDataState = self.textFieldViewModel?.isValidDataClosure?(text) ?? false
        }
        
        textFieldViewModel?.validDataStateChange = {[weak self] state in
            guard let self = self else {return}
            if state{
                self.validDataStateImageView.image = #imageLiteral(resourceName: "ic_success")
            }else{
                self.validDataStateImageView.image = #imageLiteral(resourceName: "ic_error")
            }
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        textFieldViewModel?.textFieldText = textField.text ?? ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldViewModel?.setRegisterModel?()
    }
}

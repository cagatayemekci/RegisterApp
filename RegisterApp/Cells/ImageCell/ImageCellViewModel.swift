//
//  ImageCellViewModel.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 2.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import Foundation

class ImageCellViewModel:BaseViewModel{
    
    var imageName:String = "" {
        didSet{
            imageNameChanged?()
        }
    }
    
    var imageNameChanged:(()->())?
    
    init(_ imageName: String){
        self.imageName = imageName
    }
}

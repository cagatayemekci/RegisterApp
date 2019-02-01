//
//  RegisterModel.swift
//  RegisterApp
//
//  Created by Çağatay Emekci on 1.02.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import Foundation

@dynamicMemberLookup
struct RegisterModel{
    fileprivate var errorMessage:String?
    var firstName:String?  = nil{
        didSet{
            valited()
        }
    }
    var surName:String? = ""{
        didSet{
            valited()
        }
    }
    
    subscript(dynamicMember key: String) -> String {
        switch key {
        case "fullName":
            return (firstName ?? "") + " " + (surName ?? "")
        default:
            return ""
        }
    }
    
    fileprivate mutating func valited(){
        if surName?.count ?? 0 < 10{
            errorMessage = "Surname Invalid"
            return
        }
        if firstName?.count ?? 0 < 5{
            errorMessage = "First Name Invalid"
            return
        }
        errorMessage = nil
    }
    
    func getErrorMessage() -> String?{
        return errorMessage
    }
}

//
//  File.swift
//  RunTheWorldChallenge
//
//  Created by Mena Gamal on 11/19/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//
import Foundation
import UIKit

protocol RegisterView {
    
    var textfieldPassword: UITextField!{
        get set
    }
    
    var textfieldEmail: UITextField! {
        get set
    }
    
    func update(action:RegisterViewModel.Action)
    
}

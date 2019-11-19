//
//  VerifyView.swift
//  RunTheWorldChallenge
//
//  Created by Mena Gamal on 11/20/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit

protocol VerifyView {
    
    var textfieldToken: UITextField!{
        get set
    }
    
    var textfieldEmail: UITextField! {
        get set
    }
    
    func update(action:VerifyViewModel.Action)
    
}

//
//  ViewController.swift
//  RunTheWorldChallenge
//
//  Created by Mena Gamal on 11/19/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import UIKit
import Apollo

class RegisterViewController: UIViewController ,RegisterView{
    

    @IBOutlet weak var textfieldPassword: UITextField!
    
    @IBOutlet weak var textfieldEmail: UITextField!
    
    var viewModel:RegisterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      viewModel = RegisterViewModel(view: self, vc: self)
    }

    @IBAction func signup(_ sender: Any) {
        if viewModel.validate() {
            viewModel.callRegisterMutation()
        }
    }
    
    func update(action: RegisterViewModel.Action) {
        switch action {
        case .idel:
            LoadingView.shared.stopLoading()
            break
        case .wait:
            LoadingView.shared.startLoading()
            break
        case .success:
            Toast.showAlert(viewController: self, text: "Send Successfully Check your Email", style: .alert, UIAlertAction(title: "ok", style: .default, handler: { (action) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "VerifyViewController" ) as! VerifyViewController
                self.show(vc, sender: self)
            }))
            
            // MOve To Verify
            break
        case .onError(let str) :
            Toast.showAlert(viewController: self, text: str)
            break
        }
    }
    
}


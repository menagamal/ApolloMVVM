//
//  VerifyViewController.swift
//  RunTheWorldChallenge
//
//  Created by Mena Gamal on 11/20/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import UIKit

class VerifyViewController: UIViewController ,VerifyView{
   
    @IBOutlet weak var textfieldToken: UITextField!
    @IBOutlet weak var textfieldEmail: UITextField!
    
    var viewModel:VerifyViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = VerifyViewModel(view: self, vc: self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func verify(_ sender: Any) {
        if viewModel.validate() {
            viewModel.callVerifyMutation()
        }
    }
    func update(action: VerifyViewModel.Action) {
        switch action {
        case .idel:
            LoadingView.shared.stopLoading()
            break
        case .wait:
            LoadingView.shared.startLoading()
            break
        case .success:
            Toast.showAlert(viewController: self, text: "Account Verified", style: .alert, UIAlertAction(title: "ok", style: .default, handler: { (action) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                let window1 = UIApplication.shared.delegate?.window;
                window1??.rootViewController = controller
                window1??.makeKeyAndVisible()
            }))
            
            break
        case .onError(let str) :
            Toast.showAlert(viewController: self, text: str)
            break
        }
    }
    
}

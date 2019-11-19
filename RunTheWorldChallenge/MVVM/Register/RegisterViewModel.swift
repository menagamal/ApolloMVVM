//
//  RegisterViewModel.swift
//  RunTheWorldChallenge
//
//  Created by Mena Gamal on 11/19/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit
import Apollo

class RegisterViewModel {
    
    var vc: UIViewController!
    
    var view:RegisterView!
    
    var apollo : ApolloClient!
    
    public enum Action {
        case  wait, idel, onError(str: String) ,success
    }
    init() {
        
    }
    
    init(view:RegisterView,vc: UIViewController) {
        self.view = view
        self.vc = vc
        apollo = ApolloClient(url: URL(string: "http://graphql.dev.rtw.team/query")!)
        
    }
    
    func validate() -> Bool {
        if !isValidEmail(testStr: view.textfieldEmail.text!) {
            Toast.showAlert(viewController: self.vc, text: "Enter a Valid email")
            return false
        }
        if view.textfieldPassword.text!.characters.count < 7 {
            Toast.showAlert(viewController: self.vc, text: "Password has to be at least 8 chars ")
            return false
        }
        return true
    }
    
    func callRegisterMutation()  {
        let mutation = RegisterMutation(email: view.textfieldEmail.text!, password: view.textfieldPassword.text!)
        //apollo.perform(mutation: mutation)
        view.update(action: .wait)
        apollo.perform(mutation: mutation) { result in
            self.view.update(action: .idel)
           // guard let data = try? result.get().data else { return }
           
            if let data = try? result.get().data {
                self.view.update(action: .success)
                return
            }
            if let errors = try? result.get().errors {
                
                let error = errors?.first
                self.view.update(action: .onError(str: error?.message ?? "Something went wrong"))
                
                return
            }
            
        }
    }
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
}

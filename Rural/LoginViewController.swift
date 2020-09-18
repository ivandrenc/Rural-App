//
//  ViewController.swift
//  Rural
//
//  Created by Ivan Naranjo on 24.05.20.
//  Copyright © 2020 Ivan Naranjo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var codigoDeAcceso = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldNUI.delegate = self
        textFieldClave.delegate = self
    }
    
    @IBOutlet weak var textFieldNUI: UITextField!
    @IBOutlet weak var textFieldClave: UITextField!
    @IBOutlet weak var wrongClaveLabel: UILabel!
    
    @IBAction func unwind(toLogin: UIStoryboardSegue) {
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldNUI {
            textField.resignFirstResponder()
            textFieldClave.becomeFirstResponder()
            
        } else if textField == textFieldClave {
            textField.resignFirstResponder()
            return true
        }
        
        return true
        
    }
    
    @IBAction func ingresarButtonTapped(_ sender: UIButton) {
        guard let empty = textFieldClave.text else { return }
        if String(empty) != String(codigoDeAcceso) {
            wrongClaveLabel.isHidden = false
            wrongClaveLabel.text = "Clave Incorrecta, intente de nuevo"
            
        } else {
            self.performSegue(withIdentifier: "toCuenta", sender: nil)
        }
    }
    
    


}


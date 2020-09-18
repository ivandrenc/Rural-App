//
//  RegistrateViewController.swift
//  Rural
//
//  Created by Ivan Naranjo on 25.05.20.
//  Copyright © 2020 Ivan Naranjo. All rights reserved.
//

import UIKit
import MessageUI

class RegistrateViewController: UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {
    
    var usuarios: [Usuario] = []
    var userCode = codigoUsuario(codigoUsuario: [:])
    
    var code: Int = 0
    
    //Outlets
    
    @IBOutlet weak var TextFieldNui: UITextField!
    @IBOutlet weak var TextFieldEdad: UITextField!
    @IBOutlet weak var TextFieldSexo: UITextField!
    @IBOutlet weak var TextFieldTelefono: UITextField!
    @IBOutlet weak var TextFieldEmail: UITextField!
    @IBOutlet weak var RegistrateButton: UIButton!
    
    
    //actions from the textfields
    
    
    @IBAction func nombreEditing(_ sender: Any) {
        valuesCompleted()
    }
    
    @IBAction func edadEditing(_ sender: Any) {
        valuesCompleted()
    }
    
    @IBAction func sexoEditing(_ sender: Any) {
        valuesCompleted()
    }
    
    @IBAction func telefonoEditing(_ sender: Any) {
        valuesCompleted()
    }
    
    @IBAction func emailEditing(_ sender: Any) {
        valuesCompleted()
    }
    
    //saves data of the user while tapping the button
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RegistrateButton.isEnabled = false
        
        TextFieldNui.delegate = self
        TextFieldEdad.delegate = self
        TextFieldSexo.delegate = self
        TextFieldTelefono.delegate = self
        TextFieldEmail.delegate = self
   
    }
    
    
    func valuesCompleted() {
        if TextFieldNui.text?.isEmpty != true && TextFieldEdad.text?.isEmpty != true && TextFieldSexo.text?.isEmpty != true && TextFieldTelefono.text?.isEmpty != true && TextFieldEmail.text?.isEmpty != true
        {
            let usuario = Usuario(nui: TextFieldNui.text!, edad: TextFieldEdad.text!, sexo: TextFieldSexo.text!, email: TextFieldEmail.text!, telefono: TextFieldTelefono.text!)
            self.usuarios.append(usuario)
            codeGenerator()
            self.userCode.codigoUsuario[usuario] = self.code
            RegistrateButton.isEnabled = true
            return
            
            
        }
        else {
            return
        }
    }

    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == TextFieldNui {
            textField.resignFirstResponder()
            TextFieldEdad.becomeFirstResponder()
        } else if textField == TextFieldEdad {
            textField.resignFirstResponder()
            TextFieldSexo.becomeFirstResponder()
        } else if textField == TextFieldSexo {
            textField.resignFirstResponder()
            TextFieldTelefono.becomeFirstResponder()
        } else if textField == TextFieldTelefono {
            textField.resignFirstResponder()
            TextFieldEmail.becomeFirstResponder()
        } else if textField == TextFieldEmail {
            textField.resignFirstResponder()
            valuesCompleted()
        }
        return true
    }
    
    func codeGenerator() {
        self.code = self.usuarios.last.hashValue
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? RandomNumberViewController
        destination?.codigo = self.code
        
    }
    
    
}
   
    
    

    

    
    
    

    



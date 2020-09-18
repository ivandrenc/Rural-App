//
//  RandomNumberViewController.swift
//  Rural
//
//  Created by Ivan Naranjo on 26.05.20.
//  Copyright © 2020 Ivan Naranjo. All rights reserved.
//

import UIKit

class RandomNumberViewController: UIViewController {
    
    @IBOutlet weak var codigoLabel: UILabel!
    var codigo = 0
    
    override func viewWillAppear(_ animated: Bool) {
        codigoLabel.text = String(abs(codigo))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToLogin" {
            let destination = segue.destination as? LoginViewController
            destination?.codigoDeAcceso = abs(self.codigo)
        }
        
    }
    

}

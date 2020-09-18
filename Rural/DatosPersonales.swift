//
//  DatosPersonales.swift
//  Rural
//
//  Created by Ivan Naranjo on 25.05.20.
//  Copyright © 2020 Ivan Naranjo. All rights reserved.
//

import Foundation

struct Usuario: Hashable {
    var nui: String
    var edad: String
    var sexo: String
    var email: String
    var telefono: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(nui)
        hasher.combine(edad)
        hasher.combine(sexo)
        hasher.combine(email)
        hasher.combine(telefono)
    }
    
    var hashValueUsuario: Int {
        var hasher = Hasher()
        self.hash(into: &hasher)
        return hasher.finalize()
    }
}

struct codigoUsuario: Hashable {
    var codigoUsuario: [Usuario: Int]
}





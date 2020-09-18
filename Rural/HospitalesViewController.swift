//
//  HospitalesViewController.swift
//  Rural
//
//  Created by Ivan Naranjo on 26.05.20.
//  Copyright © 2020 Ivan Naranjo. All rights reserved.
//

import UIKit
import SwiftCSV

class HospitalesViewController: UITableViewController, UISearchBarDelegate {

    var ciudad: String = ""
    var dictionary: [String:String] = [:]
    var hospitales: [String] = []
    var direcciones: [String] = []
    var telefonos: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        dictionary = [:]
        hospitales = []
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        do {
            
            let csvFile: CSV = try CSV(name: "hospitales", extension: "csv", bundle: .main, delimiter: ",", encoding: .utf8, loadColumns: true)!
            try csvFile.enumerateAsDict { array in
                self.dictionary = array
                if self.dictionary["Ciudad"]?.lowercased() == self.ciudad.lowercased() {
                    self.hospitales.append(self.dictionary["hospitales"]!)
                    self.direcciones.append(self.dictionary["direccion"]!)
                    self.telefonos.append(self.dictionary["Telefono"]!)
                }
            }
            print(self.hospitales)
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        
        } catch {
        print("did not load csv file")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitales.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hospitalCell", for: indexPath)
        cell.textLabel?.text = capitalize(text: hospitales[indexPath.row])
        return cell
    }
    
    func capitalize(text: String) -> String {
        
        return text.prefix(1).uppercased() + text.dropFirst().lowercased()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAgendar", let destination = segue.destination as? AgendarCitaViewController, let index = tableView.indexPathForSelectedRow?.row {
            destination.direccion = direcciones[index]
            destination.ciudadmapa = self.ciudad
            destination.hospitalmapa = self.hospitales[index]
            destination.telefono = self.telefonos[index]
        }
    }

}

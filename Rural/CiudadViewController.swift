//
//  AgendarViewController.swift
//  Rural
//
//  Created by Ivan Naranjo on 26.05.20.
//  Copyright © 2020 Ivan Naranjo. All rights reserved.
//

import UIKit
import SwiftCSV

class CiudadViewController: UITableViewController, UISearchBarDelegate {
    
    var ciudades: [String] = []
    var hospitales: [String] = []
    var telefonos: [String] = []
    var direcciones: [String] = []
    var sortedCiudades: [String] = []
    var searchedCiudades: [String] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        do {
            
            let csvFile: CSV = try CSV(name: "hospitales", extension: "csv", bundle: .main, delimiter: ",", encoding: .utf8, loadColumns: true)!
            try csvFile.enumerateAsDict { dict in
                self.ciudades.append(dict["Ciudad"]!)
                self.hospitales.append(dict["hospitales"]!)
                self.telefonos.append(dict["Telefono"]!)
                self.direcciones.append(dict["direccion"]!)
            }
            //filters repeated elements, makes them lowercase and sorted them alphabetically
            sortedCiudades = Array(Set(ciudades)).map { $0.lowercased()}.sorted { $0 < $1 }
            searchedCiudades = sortedCiudades
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        
        } catch {
        print("did not load csv file")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async {
            if !searchText.isEmpty {
                self.searchedCiudades = self.sortedCiudades.filter({ $0.contains(searchText.lowercased())})
                self.tableView.reloadData()
            } else {
                self.searchedCiudades = self.sortedCiudades
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedCiudades.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ciudadCell", for: indexPath)
        cell.textLabel?.text = capitalize(text: searchedCiudades[indexPath.row])
        return cell
        
    }
    
    func capitalize(text: String) -> String {
        
        return text.prefix(1).uppercased() + text.dropFirst()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHospital", let destination = segue.destination as? HospitalesViewController, let index = tableView.indexPathForSelectedRow?.row {
            destination.ciudad = searchedCiudades[index]
            print(searchedCiudades[index])
        }
    }
    
    
    
    
    
    
}

    


//
//  CitaViewController.swift
//  Rural
//
//  Created by Ivan Naranjo on 5/27/20.
//  Copyright © 2020 Ivan Naranjo. All rights reserved.
//

import UIKit

class CitaViewController: UITableViewController {

    var citas: [Citas] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
        print(citas)
    }
    
    @IBAction func unwind(toCitas: UIStoryboardSegue) {
        
    }
    
    func reload() {
        citas = CitasManager.shared.getCitas()
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "citasCell", for: indexPath)
        cell.textLabel?.text = citas[indexPath.row].hospital
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_,_, completionHandler) in
            CitasManager.deletion.deleteCita(cita: self.citas[indexPath.row])
            self.citas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
        
    }

    
    
    

}

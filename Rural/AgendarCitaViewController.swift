//
//  AgendarCitaViewController.swift
//  Rural
//
//  Created by Ivan Naranjo on 27.05.20.
//  Copyright © 2020 Ivan Naranjo. All rights reserved.
//

import MapKit
import UIKit
import CoreLocation

class AgendarCitaViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    var direccion: String = ""
    var ciudadmapa: String = ""
    var hospitalmapa: String = ""
    var telefono: String = ""
    var citas: [Citas] = []
    
    let locationManager = CLLocationManager()
    
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearch.Request!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearch.Response!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    @IBOutlet weak var direccionLabel: UILabel!
    @IBOutlet weak var telefonoLabel: UILabel!
    @IBOutlet weak var hospitalLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
        telefonoLabel.text = self.telefono
        direccionLabel.text = self.direccion
        hospitalLabel.text = self.hospitalmapa
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        localSearchRequest = MKLocalSearch.Request()
        localSearchRequest.naturalLanguageQuery = self.hospitalmapa + " " + self.ciudadmapa + ", Ecuador"
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Ubicacion no disponible", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            //3
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = self.hospitalmapa + " " + self.ciudadmapa + ", Ecuador"
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
            
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.map.centerCoordinate = self.pointAnnotation.coordinate
            self.map.addAnnotation(self.pinAnnotationView.annotation!)
        }
    }
    
    @IBAction func agendarCitaButton(_ sender: Any) {
        let _ = CitasManager.shared.create(hospital: self.hospitalmapa)
    }
    
    
    
    @IBAction func llamarButton(_ sender: UIButton) {
        UIPasteboard.general.string = self.telefono
    }
    
    
    
    


}

extension AgendarCitaViewController : CLLocationManagerDelegate {
    
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location:: (location)")
            let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            map.setRegion(region, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
        
    }
    
    
    
}

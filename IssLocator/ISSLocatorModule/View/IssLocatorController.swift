//
//  ViewController.swift
//  IssLocator
//
//  Created by Minerva Nolasco Espino on 10/05/22.
//

import UIKit
import GoogleMaps

class IssLocatorController: UIViewController {
    
    private lazy var issLocatorVM = IssLocatorViewModel()
    let showTableVC = IssLocatorTableController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "🛰 International Space Station"
        
        let camera = GMSCameraPosition.camera(withLatitude: 0.0, longitude: 0.0, zoom: 2.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            mapView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let marker = GMSMarker()

        self.issLocatorVM.requestLocation()
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            print(timer)
            self.issLocatorVM.requestLocation()
//            self.issLocatorVM.requestIssLocationWithClosure()
        }
        
        issLocatorVM.issModel.bind{ [weak self] issModel in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let latitude = self.issLocatorVM.issModel.value?.iss_position.latitude, let longitude = self.issLocatorVM.issModel.value?.iss_position.longitude{
                    let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(Float(latitude) ?? 0.0), longitude: CLLocationDegrees(Float(longitude) ?? 0.0))
                    let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 2.0)
                    print("🚨" ,coordinate.latitude, coordinate.longitude)
                    
                    mapView.camera = camera
                    marker.position = coordinate
                    marker.title = "Coordenadas, Latitud: \(coordinate.latitude), Longitud: \(coordinate.longitude)"
                    marker.icon = UIImage(named: "markerIcon")
                    marker.map = mapView
                }
            }
        }
    }
    
    @IBAction func rightBarButtonTapped(_ sender: UIBarButtonItem) {
        showTableVC.vm = issLocatorVM
        show(showTableVC, sender: Any?.self)
    }
}


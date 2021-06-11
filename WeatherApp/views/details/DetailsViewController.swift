//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 11/06/2021.
//

import UIKit
import Foundation
import CoreLocation
import MapKit

class DetailsViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapKit: MKMapView!
    @IBOutlet weak var labelName: UILabel!
    
    var latitude: Double?
    var longtitude: Double?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapKit.delegate = self
        
        let location = CLLocation(latitude: latitude ?? 0.0, longitude: longtitude ?? 0.0)
        
        let region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 5000,
            longitudinalMeters: 5000)
        
        mapKit.setCameraBoundary(
            MKMapView.CameraBoundary(coordinateRegion: region),
            animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapKit.setCameraZoomRange(zoomRange, animated: true)
        labelName.text = name ?? ""
    }

    @IBAction func backActionTapped(_ sender: Any) {
        [self .dismiss(animated: true, completion: nil)]
    }
}

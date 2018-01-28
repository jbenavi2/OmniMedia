//
//  ViewController.swift
//  OmniMedia
//
//  Created by Javier Benavides on 1/27/18.
//  Copyright © 2018 Javier Benavides. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    //Where am I
    @IBOutlet weak var locationLabel: UILabel!
    
    let manager = CLLocationManager()
    lazy var geocoder = CLGeocoder()
    var lat: Double = 0.0
    var lng: Double = 0.0
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        //let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        //let gpsLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        //let region:MKCoordinateRegion = MKCoordinateRegionMake(gpsLocation, span)
        
        //locationLabel.text = String(location.altitude)
        lat = location.coordinate.latitude
        lng = location.coordinate.longitude
        
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        // Update View
        
        
        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")
            locationLabel.text = "Unable to Find Address for Location"
            
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                locationLabel.text = placemark.locality
            } else {
                locationLabel.text = "No Matching Addresses Found"
            }
        }
    }
    
    @IBAction func setCurrentLocationLabelText(_ sender: UIButton) {
        let location = CLLocation(latitude: lat, longitude: lng)
        
        geocoder.reverseGeocodeLocation(location, completionHandler: {
          (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


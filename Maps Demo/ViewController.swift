//
//  ViewController.swift
//  Maps Demo
//
//  Created by kelvinfok on 14/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// Access core location library to locate user's location function, requires CLLocationManagerDelegate


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let latitude:CLLocationDegrees = 1.304641
        let longitude:CLLocationDegrees = 103.831821
        
        let lat_delta:CLLocationDegrees = 0.05
        let long_delta:CLLocationDegrees = 0.05
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(lat_delta, long_delta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)

        map.setRegion(region, animated: true)
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.pressed(_:)))
        
        uilpgr.minimumPressDuration = 2
        
        map.addGestureRecognizer(uilpgr)
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        let userLocation: CLLocation = locations[0]
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        
        let lat_delta:CLLocationDegrees = 0.0005
        let long_delta:CLLocationDegrees = 0.0005
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(lat_delta, long_delta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        
        
        map.setRegion(region, animated: true)
        
    }
    

    func pressed(gestureRecognizer: UIGestureRecognizer) {
        
        print("Gesture Recognized")
        
        let touchPoint = gestureRecognizer.locationInView(self.map)
        
        let newCoordinate: CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = newCoordinate
        
        annotation.title = "New Place"
        
        annotation.subtitle = "What's this awesome place called?"
        
        map.addAnnotation(annotation)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


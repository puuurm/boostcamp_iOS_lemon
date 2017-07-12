//
//  MapViewController.swift
//  Sample
//
//  Created by yangpc on 2017. 7. 5..
//  Copyright © 2017년 yangpc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    

    var mapView: MKMapView!
    var locationManager: CLLocationManager!

     
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self,
                                   action: #selector(MapViewController.mapTypeChanged(_:)),
                                   for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        /*
         Make Button: Find My Position
         */
        let currentLocationBt = UIButton(type: .roundedRect)
        currentLocationBt.setTitle("Position", for: .normal)
        currentLocationBt.tintColor = UIColor.red
        currentLocationBt.addTarget(self, action: #selector(MapViewController.findLocationAndZoomIn(_:)), for: .touchUpInside)
        
        currentLocationBt.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentLocationBt)
        
        let topbt = currentLocationBt.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -5)
        let leadingTopbt = currentLocationBt.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        topbt.isActive = true
        leadingTopbt.isActive = true
        
        /*
        Make Button: Put Pins
        */
        let putPinsButton = UIButton(type: .roundedRect)
        putPinsButton.setTitle("Put Pins", for: .normal)
        putPinsButton.tintColor = UIColor.red
        putPinsButton.addTarget(self, action: #selector(MapViewController.putThreePins(_:)), for: .touchUpInside)
        putPinsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(putPinsButton)
        
        let constraintsButton2 = putPinsButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -25)
        let leadingButton2 = putPinsButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        constraintsButton2.isActive = true
        leadingButton2.isActive = true
        
        /*
         Make Button: Iterate Pins
         */
        let IteratePinsButton = UIButton(type: .roundedRect)
        IteratePinsButton.setTitle("Navigate pins", for: .normal)
        IteratePinsButton.tintColor = UIColor.red
        IteratePinsButton.addTarget(self, action: #selector(MapViewController.itertateThreePins(_:)), for: .touchUpInside)
        IteratePinsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(IteratePinsButton)
        
        let constraintsButton3 = IteratePinsButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -45)
        let leadingButton3 = IteratePinsButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        constraintsButton3.isActive = true
        leadingButton3.isActive = true

        
    }
    
    func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    func findLocationAndZoomIn(_ btControl: UIButton) {
        print("button1")
        mapView.setUserTrackingMode(.follow, animated: true)
    }

    func putThreePins(_ btControl: UIButton) {
        print("button2")
        /*
         서울: 위도 37.487935 경도 126.857758
         고양시: 위도 37.424707 경도 127.022552
         흥미로운곳 제주: 위도 33.348885 경도 126.280975
         */
        
        /* Lotation Set */
        struct Location {
            let title: String
            let latitude: Double
            let longitude: Double
            let subtitle: String
        }
        // Locations array
        let locations = [
            Location(title: "Seoul",    latitude: 37.487935, longitude: 126.857758, subtitle: "born location"),
            Location(title: "GoyangSi", latitude: 37.424707, longitude: 127.022552,subtitle: "current location"),
            Location(title: "Jeju",     latitude: 33.348885, longitude: 126.280975,subtitle: "Interesting loation")
        ]
        
        for location in locations {
            let annotation = MKPointAnnotation()
            
            annotation.title = location.title
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.subtitle = location.subtitle
            
            mapView.addAnnotation(annotation)
        }
    }
    
    func itertateThreePins(_ btControl: UIButton) {
        for annotation in mapView.annotations {
            mapView.selectAnnotation(annotation, animated: true)
            mapView.setCenter(annotation.coordinate, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view")
    }
    
}


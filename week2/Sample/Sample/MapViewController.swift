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

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    /* 프로퍼티에 적절한 접근권한 줘보기 open, public, internal, fileprivate, private */
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var currentAnnotationIdx = 0
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        // Set it as *the* view of this view controller
        view = mapView
        mapView.delegate = self
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
        
        // 상수 이름 정확하고 나중에 알아볼 수 있도록 수정
        // ex) putPinsButtonBottomConstraint
        let constraintsButton2 = putPinsButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -25)
        let leadingButton2 = putPinsButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        constraintsButton2.isActive = true
        leadingButton2.isActive = true
        
        /*
         Make Button: Iterate Pins
         */
        // 지역상수 이름은 소문자로 시작합니다 ex) iteratePinsButton
        let IteratePinsButton = UIButton(type: .roundedRect)
        IteratePinsButton.setTitle("Navigate pins", for: .normal)
        IteratePinsButton.tintColor = UIColor.red
        IteratePinsButton.addTarget(self, action: #selector(MapViewController.itertateThreePins(_:)), for: .touchUpInside)
        IteratePinsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(IteratePinsButton)
        
        // 상수이름 명확히
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
    
    /* 제대로 동작하지 않는 것 같아요. 다른 친구들이 해결한 방법을 참고해 보는 것도 좋겠습니다 */
    func findLocationAndZoomIn(_ btControl: UIButton) {
        print("button1")
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    /* 이미 핀이 놓여있다면 추가로 핀을 놓지 않는 것이 좋겠습니다 */
    func putThreePins(_ btControl: UIButton) {
        print("button2")
        /*
         서울: 위도 37.487935 경도 126.857758
         고양시: 위도 37.424707 경도 127.022552
         흥미로운곳 제주: 위도 33.348885 경도 126.280975
         */
        
        /* Lotation Set */
        /* 적절한 접근권한 줘보기 open, public, internal, fileprivate, private */
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
    
    /* 실제로 사용자의 입장에서는 마지막 핀의 위치에만 가도록 구현되어 있습니다. 사용자가 버튼을 누를 때 마다 다음 장소로 이동할 수 있도록 수정해보세요 */
    func itertateThreePins(_ btControl: UIButton) {
        if mapView.annotations.isEmpty {return}
        mapView.setCenter(mapView.annotations[currentAnnotationIdx].coordinate, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if currentAnnotationIdx >= mapView.annotations.count {
            currentAnnotationIdx = 0
            return
        }
        
        if animated {
            mapView.setCenter(mapView.annotations[currentAnnotationIdx].coordinate, animated: true)
            currentAnnotationIdx += 1
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view")
    }
    
}


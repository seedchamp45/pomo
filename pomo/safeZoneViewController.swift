//
//  safeZoneViewController.swift
//  pomo
//
//  Created by Thanawith Munkatitum on 10/8/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit
import GoogleMaps



class safeZoneViewController: UIViewController {
    
    var mapView: GMSMapView?
    
    var currentDestination: VacationDestination?
    
    let destinations = [VacationDestination(name: "Embarcadero Bart Station", location: CLLocationCoordinate2DMake(37.792905, -122.397059), zoom: 14), VacationDestination(name: "Ferry Building", location: CLLocationCoordinate2DMake(37.795434, -122.39473), zoom: 18), VacationDestination(name: "Coit Tower", location: CLLocationCoordinate2DMake(37.802378, -122.405811), zoom: 15), VacationDestination(name: "Fisherman's Wharf", location: CLLocationCoordinate2DMake(37.808, -122.417743), zoom: 15), VacationDestination(name: "Golden Gate Bridge", location: CLLocationCoordinate2DMake(37.807664, -122.475069), zoom: 13)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyA0QlNOrMY6JU7wqgBXBamQq1v9wbR11Z0")
        let camera = GMSCameraPosition.cameraWithLatitude(37.621262, longitude: -122.378945, zoom: 12)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(37.621262, -122.378945)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "SFO Airport"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
    }
    
    func next() {
        
        if currentDestination == nil {
            currentDestination = destinations.first
        } else {
            if let index = destinations.indexOf(currentDestination!) where index < destinations.count - 1 {
                currentDestination = destinations[index + 1]
            }
        }
        
        setMapCamera()
    }
    
    private func setMapCamera() {
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        mapView?.animateToCameraPosition(GMSCameraPosition.cameraWithTarget(currentDestination!.location, zoom: currentDestination!.zoom))
        CATransaction.commit()
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination?.name
        marker.map = mapView
    }


}

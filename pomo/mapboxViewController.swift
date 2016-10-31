//
//  mapboxViewController.swift
//  pomo
//
//  Created by Kittipol Munkatitum on 10/30/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit
import CoreLocation
import MapboxDirections
import Mapbox

class mapboxViewController: UIViewController, MGLMapViewDelegate {

    
    let MapboxAccessToken = "<# your Mapbox access token #>"
    @IBOutlet var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(MapboxAccessToken != "pk.eyJ1Ijoic2VlZGNoYW1wNDUiLCJhIjoiY2l1d2QzY3d6MDRmcTJ1czY5ZHVlN2g0dyJ9.qQB7cOqmgK3OZPuqe0SsmQ", "You must set `MapboxAccessToken` to your Mapbox access token.")
        MGLAccountManager.setAccessToken(MapboxAccessToken)
        mapView.delegate = self
        
        
        
        
        
        
        
        
        
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 45.52258, longitude: -122.6732)
        point.title = "Voodoo Doughnut"
        point.subtitle = "22 SW 3rd Avenue Portland Oregon, U.S.A."
        
        mapView.addAnnotation(point)

    }
    
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always try to show a callout when an annotation is tapped.
        return true
    }
    
    // Or, if you’re using Swift 3 in Xcode 8.0, be sure to add an underscore before the method parameters:
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always try to show a callout when an annotation is tapped.
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let options = RouteOptions(waypoints: [
            Waypoint(coordinate: CLLocationCoordinate2D(latitude: 38.9131752, longitude: -77.0324047), name: "Mapbox"),
            Waypoint(coordinate: CLLocationCoordinate2D(latitude: 38.8977, longitude: -77.0365), name: "White House"),
            ])
        options.includesSteps = true
        
        Directions(accessToken: MapboxAccessToken).calculateDirections(options: options) { (waypoints, routes, error) in
            guard error == nil else {
                print("Error calculating directions: \(error!)")
                return
            }
            
            if let route = routes?.first, let leg = route.legs.first {
                print("Route via \(leg):")
                
                let distanceFormatter = LengthFormatter()
                let formattedDistance = distanceFormatter.string(fromMeters: route.distance)
                
                let travelTimeFormatter = DateComponentsFormatter()
                travelTimeFormatter.unitsStyle = .short
                let formattedTravelTime = travelTimeFormatter.string(from: route.expectedTravelTime)
                
                print("Distance: \(formattedDistance); ETA: \(formattedTravelTime!)")
                
                for step in leg.steps {
                    print("\(step.instructions)")
                    if step.distance > 0 {
                        let formattedDistance = distanceFormatter.string(fromMeters: step.distance)
                        print("— \(formattedDistance) —")
                    }
                }
                
                if route.coordinateCount > 0 {
                    // Convert the route’s coordinates into a polyline.
                    var routeCoordinates = route.coordinates!
                    let routeLine = MGLPolyline(coordinates: &routeCoordinates, count: route.coordinateCount)
                    
                    // Add the polyline to the map and fit the viewport to the polyline.
                    self.mapView.addAnnotation(routeLine)
                    self.mapView.setVisibleCoordinates(&routeCoordinates, count: route.coordinateCount, edgePadding:                 UIEdgeInsets.zero, animated: true)
                }
            }
        }
    }

        
    


}

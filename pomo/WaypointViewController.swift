//
//  WaypointViewController.swift
//  PXGoogleDirectionsSample
//
//  Created by Romain on 27/03/2015.
//  Copyright (c) 2015 Poulpix. All rights reserved.
//

import UIKit
import CoreLocation


class WaypointViewController: UIViewController {
	@IBOutlet weak var namedLocationView: UIView!
	@IBOutlet weak var coordinateLocationView: UIView!
	@IBOutlet weak var namedLocationField: UITextField!
	@IBOutlet weak var latitudeField: UITextField!
	@IBOutlet weak var longitudeField: UITextField!
	var delegate: MainViewControllerDelegate!
	
	@IBAction func cancelButtonTouched(sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func locationTypeChanged(sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			namedLocationView.isHidden = false
			coordinateLocationView.isHidden = true
		case 1:
			namedLocationView.isHidden = true
			coordinateLocationView.isHidden = false
		default:
			break
		}
	}
	
	@IBAction func addWaypointButtonTouched(sender: UIButton) {
		var waypoint: PXLocation?
		if !namedLocationView.isHidden {
			if namedLocationField.text!.characters.count > 0 {
				waypoint = PXLocation.NamedLocation(namedLocationField.text!)
			}
		}
		if !coordinateLocationView.isHidden {
			if latitudeField.text!.characters.count > 0 && longitudeField.text!.characters.count > 0 {
				let lat = NSString(string: latitudeField.text!).doubleValue
				let lng = NSString(string: longitudeField.text!).doubleValue
				waypoint = PXLocation.CoordinateLocation(CLLocationCoordinate2DMake(lat, lng))
			}
		}
		if let wp = waypoint {
			delegate.didAddWaypoint(waypoint: wp)
			dismiss(animated: true, completion: nil)
		}
	}
}

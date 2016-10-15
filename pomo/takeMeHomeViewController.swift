//
//  takeMeHomeViewController.swift
//  pomo
//
//  Created by Thanawith Munkatitum on 10/12/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit
import GoogleMaps


protocol MainViewControllerDelegate {
    func didAddWaypoint(waypoint: PXLocation)
}
class takeMeHomeViewController: UIViewController {
    @IBOutlet weak var originField: UITextField!
    @IBOutlet weak var destinationField: UITextField!
    @IBOutlet weak var modeField: UISegmentedControl!
    @IBOutlet weak var advancedSwitch: UISwitch!
    @IBOutlet weak var advancedView: UIView!
    @IBOutlet weak var unitField: UISegmentedControl!
    @IBOutlet weak var transitRoutingField: UISegmentedControl!
    @IBOutlet weak var alternativeSwitch: UISwitch!
    @IBOutlet weak var busSwitch: UISwitch!
    @IBOutlet weak var subwaySwitch: UISwitch!
    @IBOutlet weak var trainSwitch: UISwitch!
    @IBOutlet weak var tramSwitch: UISwitch!
    @IBOutlet weak var railSwitch: UISwitch!
    @IBOutlet weak var avoidTollsSwitch: UISwitch!
    @IBOutlet weak var avoidHighwaysSwitch: UISwitch!
    @IBOutlet weak var avoidFerriesSwitch: UISwitch!
    @IBOutlet weak var startArriveField: UISegmentedControl!
    @IBOutlet weak var startArriveDateField: UITextField!
    @IBOutlet weak var waypointsLabel: UILabel!
    @IBOutlet weak var optimizeWaypointsSwitch: UISwitch!
    @IBOutlet weak var languageField: UISegmentedControl!
    var startArriveDate: NSDate?
    var waypoints: [PXLocation] = [PXLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateStartArriveDateField(newDate: nil)
        updateWaypointsField()
        let datePicker = UIDatePicker()
        datePicker.sizeToFit()
        datePicker.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        datePicker.datePickerMode = .dateAndTime
        datePicker.minuteInterval = 5
        startArriveDateField.inputView = datePicker
        let keyboardDoneButtonView = UIToolbar()
        keyboardDoneButtonView.barStyle = .black
        keyboardDoneButtonView.isTranslucent = true
        keyboardDoneButtonView.tintColor = nil
        keyboardDoneButtonView.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(takeMeHomeViewController.doneButtonTouched(sender:)))
        let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(takeMeHomeViewController.clearButtonTouched(sender:)))
        keyboardDoneButtonView.setItems([doneButton, clearButton], animated: false)
        startArriveDateField.inputAccessoryView = keyboardDoneButtonView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private var directionsAPI: PXGoogleDirections {
        return (UIApplication.shared.delegate as! AppDelegate).directionsAPI
    }
    
    private func modeFromField() -> PXGoogleDirectionsMode {
        return PXGoogleDirectionsMode(rawValue: modeField.selectedSegmentIndex)!
    }
    
    private func unitFromField() -> PXGoogleDirectionsUnit {
        return PXGoogleDirectionsUnit(rawValue: unitField.selectedSegmentIndex)!
    }
    
    private func transitRoutingPreferenceFromField() -> PXGoogleDirectionsTransitRoutingPreference? {
        return PXGoogleDirectionsTransitRoutingPreference(rawValue: transitRoutingField.selectedSegmentIndex)
    }
    
    private func languageFromField() -> String {
        return languageField.titleForSegment(at: languageField.selectedSegmentIndex)!
        // There are quite a few other languages available, see here for more information: https://developers.google.com/maps/faq#languagesupport
    }
    
    private func updateStartArriveDateField(newDate: NSDate?) {
        startArriveDate = newDate
        if let saDate = startArriveDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium


            dateFormatter.timeStyle = .short
            startArriveDateField.text = dateFormatter.string(from: saDate as Date)
        } else {
            startArriveDateField.text = ""
        }
    }
    
   func updateWaypointsField() {
        switch (waypoints).count {
        case 0:
            waypointsLabel.text = "No waypoints"
        case 1:
            waypointsLabel.text = "1 waypoint"
        default:
            waypointsLabel.text = "\((waypoints).count) waypoints"
        }
    }
    
    @IBAction func advancedOptionsChanged(sender: UISwitch) {
        UIView.animate(withDuration: 0.5, animations: {
            self.advancedView.alpha =  (self.advancedSwitch.isOn ? 1.0 : 0.0)
        })
    }
    
    @IBAction func selectDateButtonTouched(sender: UIButton) {
        startArriveDateField.isEnabled = true
        startArriveDateField.becomeFirstResponder()
    }
    
    func doneButtonTouched(sender: UIBarButtonItem) {
        updateStartArriveDateField(newDate: (startArriveDateField.inputView as! UIDatePicker).date as NSDate?)
        startArriveDateField.resignFirstResponder()
        startArriveDateField.isEnabled = false
    }
    
    func clearButtonTouched(sender: UIBarButtonItem) {
        updateStartArriveDateField(newDate: nil)
        startArriveDateField.resignFirstResponder()
        startArriveDateField.isEnabled = false
    }
    
    @IBAction func addWaypointButtonTouched(sender: UIButton) {
        if let wpvc = self.storyboard?.instantiateViewController(withIdentifier: "Waypoint") as? WaypointViewController {
            wpvc.delegate = self
            self.present(wpvc, animated: true, completion: nil)
        }
    }
    
    @IBAction func clearWaypointsButtonTouched(sender: UIButton) {
        waypoints.removeAll(keepingCapacity: false)
        updateWaypointsField()
    }
    
    @IBAction func goButtonTouched(sender: UIButton) {
        directionsAPI.delegate = self
        directionsAPI.from = PXLocation.NamedLocation(originField.text!)
        directionsAPI.to = PXLocation.NamedLocation(destinationField.text!)
        directionsAPI.mode = modeFromField()
        if advancedSwitch.isOn {
            directionsAPI.transitRoutingPreference = transitRoutingPreferenceFromField()
            directionsAPI.units = unitFromField()
            directionsAPI.alternatives = alternativeSwitch.isOn
            directionsAPI.transitModes = Set()
            if busSwitch.isOn {
                directionsAPI.transitModes.insert(.Bus)
            }
            if subwaySwitch.isOn {
                directionsAPI.transitModes.insert(.Subway)
            }
            if trainSwitch.isOn {
                directionsAPI.transitModes.insert(.Train)
            }
            if tramSwitch.isOn {
                directionsAPI.transitModes.insert(.Tram)
            }
            if railSwitch.isOn {
                directionsAPI.transitModes.insert(.Rail)
            }
            directionsAPI.featuresToAvoid = Set()
            if avoidTollsSwitch.isOn {
                directionsAPI.featuresToAvoid.insert(.Tolls)
            }
            if avoidHighwaysSwitch.isOn {
                directionsAPI.featuresToAvoid.insert(.Highways)
            }
            if avoidFerriesSwitch.isOn {
                directionsAPI.featuresToAvoid.insert(.Ferries)
            }
            switch startArriveField.selectedSegmentIndex {
            case 0:
                directionsAPI.departureTime = .Now
                directionsAPI.arrivalTime = nil
            case 1:
                if let saDate = startArriveDate {
                    directionsAPI.departureTime = PXTime.timeFromDate(date: saDate)
                    directionsAPI.arrivalTime = nil
                } else {
                    return
                }
            case 2:
                if let saDate = startArriveDate {
                    directionsAPI.departureTime = nil
                    directionsAPI.arrivalTime = PXTime.timeFromDate(date: saDate)
                } else {
                    return
                }
            default:
                break
            }
            directionsAPI.waypoints = waypoints
            directionsAPI.optimizeWaypoints = optimizeWaypointsSwitch.isOn
            directionsAPI.language = languageFromField()
        } else {
            directionsAPI.transitRoutingPreference = nil
            directionsAPI.units = nil
            directionsAPI.alternatives = nil
            directionsAPI.transitModes = Set()
            directionsAPI.featuresToAvoid = Set()
            directionsAPI.departureTime = nil
            directionsAPI.arrivalTime = nil
            directionsAPI.waypoints = [PXLocation]()
            directionsAPI.optimizeWaypoints = nil
            directionsAPI.language = nil
        }
        // directionsAPI.region = "fr" // Feature not demonstrated in this sample app
        directionsAPI.calculateDirections { (response) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                switch response {
                case let .Error(_, error):
                    let alert = UIAlertController(title: "PXGoogleDirectionsSample", message: "Error: \(error.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                case let .Success(request, routes):
                    if let rvc = self.storyboard?.instantiateViewController(withIdentifier: "Results") as? ResultsViewController {
                        rvc.request = request
                        rvc.results = routes
                        self.present(rvc, animated: true, completion: nil)
                    }
                }
            })
        }
    }
}

extension takeMeHomeViewController: PXGoogleDirectionsDelegate {
    func googleDirectionsWillSendRequestToAPI(googleDirections: PXGoogleDirections, withURL requestURL: NSURL) -> Bool {
        NSLog("googleDirectionsWillSendRequestToAPI:withURL:")
        return true
    }
    
    func googleDirectionsDidSendRequestToAPI(googleDirections: PXGoogleDirections, withURL requestURL: NSURL) {
        NSLog("googleDirectionsDidSendRequestToAPI:withURL:")
        NSLog("\(requestURL.absoluteString?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed))")
    }
    
    func googleDirections(googleDirections: PXGoogleDirections, didReceiveRawDataFromAPI data: NSData) {
        NSLog("googleDirections:didReceiveRawDataFromAPI:")
        NSLog(NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as! String)
    }
    
    func googleDirectionsRequestDidFail(googleDirections: PXGoogleDirections, withError error: NSError) {
        NSLog("googleDirectionsRequestDidFail:withError:")
        NSLog("\(error)")
    }
    
    func googleDirections(googleDirections: PXGoogleDirections, didReceiveResponseFromAPI apiResponse: [PXGoogleDirectionsRoute]) {
        NSLog("googleDirections:didReceiveResponseFromAPI:")
        NSLog("Got \(apiResponse.count) routes")
        for i in 0 ..< apiResponse.count {
            NSLog("Route \(i) has \(apiResponse[i].legs.count) legs")
        }
    }
}

extension takeMeHomeViewController: MainViewControllerDelegate{
    func didAddWaypoint(waypoint: PXLocation) {
        waypoints.append(waypoint)
        self.updateWaypointsField()
    }
}


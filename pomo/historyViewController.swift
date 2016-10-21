//
//  historyViewController.swift
//  pomo
//
//  Created by Thanawith Munkatitum on 10/8/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit
import GoogleMaps
import CVCalendar

class historyViewController: UIViewController, CVCalendarViewDelegate, CVCalendarMenuViewDelegate ,CVCalendarViewAppearanceDelegate, CLLocationManagerDelegate {
    var selectedDay:DayView!
    
    struct Color {
        static let selectedText = UIColor.white
        static let text = UIColor.black
        static let textDisabled = UIColor.gray
        static let selectionBackground = UIColor(red: 0.2, green: 0.2, blue: 1.0, alpha: 1.0)
        static let sundayText = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0)
        static let sundayTextDisabled = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0)
        static let sundaySelectionBackground = sundayText
    }
    
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .sunday
    }
    
    // MARK: Optional methods
    
    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        return weekday == .sunday ? UIColor(red: 1.0, green: 0.5, blue: 0.5, alpha: 1.0) : UIColor.white
    }
    
//    func shouldShowWeekdaysOut() -> Bool {
//        return shouldShowWeekdaysOut
//    }
//    
    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }
    
    private func shouldSelectDayView(dayView: DayView) -> Bool {
        return arc4random_uniform(3) == 0 ? true : false
    }
    
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        print("\(dayView.date.commonDescription) is selected!")
        selectedDay = dayView
        checkday = 1
        if checkday == 0
        {
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "History", style: .plain, target: self, action: #selector(historyViewController.Calender as (historyViewController) -> () -> ()))
        }
        else
        {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(historyViewController.next as (historyViewController) -> () -> ()))
        }
        
        self.next()
    }
    
    
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        let day = dayView.date.day
        let randomDay = Int(arc4random_uniform(31))
        if day == randomDay {
            return true
        }
        
        return false
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        
        let red = CGFloat(arc4random_uniform(600) / 255)
        let green = CGFloat(arc4random_uniform(600) / 255)
        let blue = CGFloat(arc4random_uniform(600) / 255)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        let numberOfDots = Int(arc4random_uniform(3) + 1)
        switch(numberOfDots) {
        case 2:
            return [color, color]
        case 3:
            return [color, color, color]
        default:
            return [color] // return 1 dot
        }
    }
    
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 2
    }
    
    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont { return UIFont.systemFont(ofSize: 14) }
    
    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (_, .selected, _), (_, .highlighted, _): return Color.selectedText
        case (.sunday, .in, _): return Color.sundayText
        case (.sunday, _, _): return Color.sundayTextDisabled
        case (_, .in, _): return Color.text
        default: return Color.textDisabled
        }
    }
    
    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (.sunday, .selected, _), (.sunday, .highlighted, _): return Color.sundaySelectionBackground
        case (_, .selected, _), (_, .highlighted, _): return Color.selectionBackground
        default: return nil
        }
    }

    
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 13
    }
    
    
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .short
    }
    
    func selectionViewPath() -> ((CGRect) -> (UIBezierPath)) {
        return { UIBezierPath(rect: CGRect(x: 0, y: 0, width: $0.width, height: $0.height)) }
    }
    
    func shouldShowCustomSingleSelection() -> Bool {
        return false
    }
    
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: CVShape.circle)
        circleView.fillColor = .colorFromCode(0xCCCCCC)
        return circleView
    }
    
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }
    
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        let π = M_PI
        
        let ringSpacing: CGFloat = 3.0
        let ringInsetWidth: CGFloat = 1.0
        let ringVerticalOffset: CGFloat = 1.0
        var ringLayer: CAShapeLayer!
        let ringLineWidth: CGFloat = 4.0
        let ringLineColour: UIColor = .blue
        
        let newView = UIView(frame: dayView.bounds)
        
        let diameter: CGFloat = (newView.bounds.width) - ringSpacing
        let radius: CGFloat = diameter / 2.0
        
        let rect = CGRect(x: newView.frame.midX-radius, y: newView.frame.midY-radius-ringVerticalOffset, width: diameter, height: diameter)
        
        ringLayer = CAShapeLayer()
        newView.layer.addSublayer(ringLayer)
        
        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColour.cgColor
        
        let ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
        let ringRect: CGRect = rect.insetBy(dx: ringLineWidthInset, dy: ringLineWidthInset)
        let centrePoint: CGPoint = CGPoint(x: ringRect.midX, y: ringRect.midY)
        let startAngle: CGFloat = CGFloat(-π/2.0)
        let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle
        let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        ringLayer.path = ringPath.cgPath
        ringLayer.frame = newView.layer.bounds
        
        return newView
    }
    
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if (Int(arc4random_uniform(3)) == 1) {
            return true
        }
        
        return false
    }
    
    func dayOfWeekTextColor() -> UIColor {
        return UIColor.white
    }
    
    func dayOfWeekBackGroundColor() -> UIColor {
        return UIColor.orange
    }

  

    

    
  //  @IBOutlet weak var calendarView: CVCalendarView!
    var mapView: GMSMapView?
   
    var menuView: CVCalendarMenuView!
    var calendarView: CVCalendarView!
    var center:CLLocationCoordinate2D? = nil
    var currentDestination: VacationDestination?
    var Lat:Double?
    var Long:Double?
    var checkday = 0
    let i = arc4random()%10
    let j = arc4random()%200
    let destinations = [VacationDestination(name: "Siam Square", location: CLLocationCoordinate2DMake(13.7447, 100.5348), zoom: 14), VacationDestination(name: "Central Rama 3", location: CLLocationCoordinate2DMake(13.6980, 100.5381), zoom: 18), VacationDestination(name: "Central World", location: CLLocationCoordinate2DMake(13.7469, 100.5390), zoom: 15), VacationDestination(name: "Assumption Thonburi", location: CLLocationCoordinate2DMake(13.7327, 100.3707), zoom: 15), VacationDestination(name: "Golden Gate Bridge", location: CLLocationCoordinate2DMake(13.7261, 100.5348), zoom: 13)]
    
    let locationManager = CLLocationManager()
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        
        center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        
        
        self.locationManager.stopUpdatingLocation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(center)
        
        
        // CVCalendarMenuView initialization with frame
        self.menuView = CVCalendarMenuView(frame: CGRect.init(x: 37.5, y: 70, width: 300, height: 15))
       
        // CVCalendarView initialization with frame
        self.calendarView = CVCalendarView(frame: CGRect.init(x: 37.5, y: 90, width: 300, height: 450))
        self.calendarView.backgroundColor = UIColor.white
        
        // Appearance delegate [Unnecessary]
        self.calendarView.calendarAppearanceDelegate = self
        
        // Animator delegate [Unnecessary]
        self.calendarView.animatorDelegate = self
        
        // Menu delegate [Required]
        self.menuView.menuViewDelegate = self
        
        // Calendar delegate [Required]
        self.calendarView.calendarDelegate = self
        
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        
        Lat = locationManager.location?.coordinate.latitude;
        Long = locationManager.location?.coordinate.longitude;
        
        
        self.mapView?.isMyLocationEnabled = true
        
   
        let camera = GMSCameraPosition.camera(withLatitude: Lat!, longitude: Long!, zoom: 12)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        
        view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(Lat!, Long!)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Your location"
        marker.map = mapView
        print(checkday)
        if checkday == 0
        {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "History", style: .plain, target: self, action: #selector(historyViewController.Calender as (historyViewController) -> () -> ()))
        }
        else
        {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(historyViewController.next as (historyViewController) -> () -> ()))
        }
        
        
    }
    
    func Calender() {
     print("show")
        
       
            self.view.addSubview(calendarView)
        
        self.view.addSubview(menuView)


    }
    

    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error: " + error.localizedDescription)
    }
    
    func next() {
        
        if currentDestination == nil {
            currentDestination = destinations.first
            checkday = 0
        } else {
            if let index = destinations.index(of: currentDestination!) , index < destinations.count - 1 {
                currentDestination = destinations[index + 1]
               checkday = 1
                print("index:\(index)")
                if index >= 3
                {
                    checkday = 0
                    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "History", style: .plain, target: self, action: #selector(historyViewController.Calender as (historyViewController) -> () -> ()))
                    
                    
                      currentDestination = destinations.first
                 
                }
                else
                {
                    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(historyViewController.next as (historyViewController) -> () -> ()))
                }
            }
        }
        
        setMapCamera()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Commit frames' updates
        self.menuView.commitMenuViewUpdate()
        self.calendarView.commitCalendarViewUpdate()
    }
    
    fileprivate func setMapCamera() {
        CATransaction.begin()
        CATransaction.setValue(1, forKey: kCATransactionAnimationDuration)
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom))
        CATransaction.commit()
        
        print(checkday)
        self.calendarView.removeFromSuperview()
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination?.name
        marker.map = mapView
    }

}



//extension historyViewController: CVCalendarViewAppearanceDelegate {
//    func dayLabelPresentWeekdayInitallyBold() -> Bool {
//        return false
//    }
//    
//    func spaceBetweenDayViews() -> CGFloat {
//        return 2
//    }
//    
//    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont { return UIFont.systemFont(ofSize: 14) }
//    
//    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
//        switch (weekDay, status, present) {
//        case (_, .selected, _), (_, .highlighted, _): return Color.selectedText
//        case (.sunday, .in, _): return Color.sundayText
//        case (.sunday, _, _): return Color.sundayTextDisabled
//        case (_, .in, _): return Color.text
//        default: return Color.textDisabled
//        }
//    }
//    
//    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
//        switch (weekDay, status, present) {
//        case (.sunday, .selected, _), (.sunday, .highlighted, _): return Color.sundaySelectionBackground
//        case (_, .selected, _), (_, .highlighted, _): return Color.selectionBackground
//        default: return nil
//        }
//    }
//}

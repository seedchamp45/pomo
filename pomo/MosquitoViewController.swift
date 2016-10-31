//
//  MosquitoViewController.swift
//  pomo
//
//  Created by Thanawith Munkatitum on 10/12/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit
import AlarmKit
import Foundation


class MosquitoViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var onSwitch: UISwitch!
    @IBOutlet weak var triggeredLabel: UILabel!
    
    var alarm: AlarmKit.Alarm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reset()
        
        // Create an alarm with a sensible default time 12:00pm
        self.alarm = AlarmKit.Alarm(hour:23, minute:39, {
            debugPrint("Alarm triggered!")
            self.triggeredLabel.text = "Alarm Triggered!"
            AlarmSoundHelper.startPlaying()
        })
        
        self.datePicker.addTarget(self, action: #selector(MosquitoViewController.timeChanged), for: UIControlEvents.valueChanged)
        self.onSwitch.addTarget(self, action: #selector(MosquitoViewController.switchChanged), for: UIControlEvents.valueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    var player: AVAudioPlayer?
//    
//    func playSound() {
//        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "m4a") else {
//            print("url not found")
//            return
//        }
//        
//        do {
//            /// this codes for making this app ready to takeover the device audio
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//            try AVAudioSession.sharedInstance().setActive(true)
//            
//            /// change fileTypeHint according to the type of your audio file (you can omit this)
//            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)
//            
//            // no need for prepareToPlay because prepareToPlay is happen automatically when calling play()
//            player!.play()
//        } catch let error as NSError {
//            print("error: \(error.localizedDescription)")
//        }
//    }
    
    func timeChanged() {
        let (hour, minute) = components(self.datePicker.date)
        
        // If we want, we can change the hour and minute after the alarm's creation
        self.alarm.hour = hour
        self.alarm.minute = minute
        
        reset()
    }
    
    func switchChanged() {
        if self.onSwitch.isOn {
            self.alarm.turnOn()
        } else {
            self.alarm.turnOff()
            AlarmSoundHelper.stopPlaying()
            self.triggeredLabel.text = "Alarm OFF!"
        }
    }
    
    ///MARK: Helpers
    func reset() {
        self.triggeredLabel.text = "Waiting..."
    }
    
    func components(_ date:Date) -> (Int, Int) {
        let flags = NSCalendar.Unit.hour.union(NSCalendar.Unit.minute)
        let comps = (Calendar.current as NSCalendar).components(flags, from: date)
        return (comps.hour!, comps.minute!)
    }

}


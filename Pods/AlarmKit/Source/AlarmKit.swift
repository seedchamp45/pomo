//
// AlarmKit.swift
//
// Copyright (c) 2015 Daniel Brim <brimizer@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public enum Weekday:NSInteger {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
}

open class Alarm: NSObject {
    open var hour: Int
    open var minute: Int
    open var weekdays: [Weekday]?
    open var isOn: Bool = true
    open var block: () -> ()

    fileprivate var timer: Timer?
    fileprivate var repeats: Bool = false
    
    // If you don't know the time yet, then create a time-less alarm.
    // It will be off by default. You must call turnOn() after setting a time.
    public override init() {
        self.hour = 0
        self.minute = 0
        self.block = {}
        self.repeats = false
        
        super.init()
    }
    
    // If you don't know the time yet, then create a time-less alarm.
    // It will be off by default. You must call turnOn() after setting a time.
    public convenience init(_ block: @escaping () -> ()) {
        
        self.init()
        
        self.block = block
        self.repeats = false
    }

    public convenience init(weekdays:[Weekday], hour:Int, minute:Int, _ block: @escaping () -> ()) {

        self.init()
        
        self.hour = hour
        self.minute = minute
        self.weekdays = weekdays
        self.block = block
        self.repeats = true

        self.turnOn()
    }

    public convenience init(hour:Int, minute:Int, _ block: @escaping () -> ()) {

        self.init()
        
        self.hour = hour
        self.minute = minute
        self.block = block
        self.repeats = false

        self.turnOn()
    }
    

    /// Returns a tuple of (weekay, hour, minute, second) of the current date/time
    fileprivate func currentDateComponents() -> (Int, Int, Int, Int) {
        let now = Date()
        let flags = NSCalendar.Unit.weekday.union(NSCalendar.Unit.hour).union(NSCalendar.Unit.minute).union(NSCalendar.Unit.second)
        let comps = (Calendar.current as NSCalendar).components(flags, from: now)
        return (comps.weekday!, comps.hour!, comps.minute!, comps.second!)
    }

    fileprivate func checkUpdate() {

        let (weekday, hour, minute, second) = currentDateComponents()

        // Only continue if this alarm doesn't repeat and is a one-time-use alarm
        // Or if it does repeat, and today is the correct day
        guard (!self.repeats || self.weekdays?.contains(Weekday(rawValue:weekday)!) == true) else {
            return
        }

        // Now check the hour and minute
        if hour == self.hour && minute == self.minute && second == 0 {
            // If so, call the callback
            self.block()

            // If this alarm is one time use, turn it off
            if !self.repeats {
                self.turnOff()
            }
        }
    }

    open func turnOn() {
        guard self.timer == nil || self.timer?.isValid == false else {
            self.isOn = true
            return
        }

        self.timer?.invalidate() // Invalidate, just in case
        self.timer = Timer.every(1.0, checkUpdate)
        self.isOn = true
    }

    open func turnOff() {
        self.timer?.invalidate()
        self.isOn = false
    }
}

private class NSTimerActor {
    let block: () -> Void

    init(_ block: @escaping () -> Void) {
        self.block = block
    }

    @objc func fire() {
        block()
    }
}

private extension Timer {
    class func new(every interval: TimeInterval, _ block: @escaping () -> ()) -> Timer {
        let actor = NSTimerActor(block)
        return self.init(timeInterval: interval, target: actor, selector: #selector(NSTimerActor.fire), userInfo: nil, repeats: true)
    }

    func start(runLoop: RunLoop = RunLoop.current, modes: String...) {
        let modes = modes.isEmpty ? [RunLoopMode.defaultRunLoopMode] : [modes]

        for mode in modes {
            runLoop.add(self, forMode: mode as! RunLoopMode)
        }
    }

    class func every(_ interval:TimeInterval, _ block: @escaping () -> ()) -> Timer {
        let timer = Timer.new(every: interval, block)
        timer.start()
        return timer
    }
}

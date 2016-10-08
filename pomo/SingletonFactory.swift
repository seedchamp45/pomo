//
//  SingletonFactory.swift
//  pomo
//
//  Created by Thanawith Munkatitum on 10/8/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import Foundation

private var singleton_map: [String : SingletonProtocol] = [String : SingletonProtocol]()
private var singleton_queue: dispatch_queue_t = dispatch_queue_create("com.pomo.singletonfactory", DISPATCH_QUEUE_SERIAL)

class SingletonFactory <T: SingletonProtocol>
{
    static func shareInstance() -> T?
    {
        var dev: T?
        dispatch_sync(singleton_queue)
        {
            let identifier = T.className()
            var singleton: T? = singleton_map[identifier] as? T
                if singleton != nil
                {
                if let instance = T.createInstance() as? T{
                        singleton = instance
                        singleton_map.updateValue(singleton!, forKey: identifier)
                }
            }
            dev = singleton
            
        }
        return dev
    }
    static func setShareInstance(singleton: SingletonProtocol, Identifier:NSString) -> Void
    {
        singleton_map.updateValue(singleton, forKey: Identifier as String)
    }
}
//
//  SingletonProtocol.swift
//  pomo
//
//  Created by Thanawith Munkatitum on 10/8/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import Foundation

protocol SingletonProtocol {
    static func className() -> String
    static func createInstance() -> AnyObject?
}
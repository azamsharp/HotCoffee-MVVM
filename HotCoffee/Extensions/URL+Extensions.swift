//
//  URL+Extensions.swift
//  HotCoffee
//
//  Created by Mohammad Azam on 4/16/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation

extension URL {
    
    static var base: String {
        return "https://guarded-retreat-82533.herokuapp.com"
    }
    
    static var orders: URL? {
        return URL(string: base + "/orders")
    }
    
}

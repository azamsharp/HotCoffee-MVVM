//
//  Order.swift
//  HotCoffee
//
//  Created by Mohammad Azam on 4/15/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation

enum CoffeeType: String,Codable, CaseIterable {
    case cappuccino
    case latte
    case espressino
    case cortado
}

enum CoffeeSize: String,Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}

extension Order {
    
    static func create(vm: AddCoffeeOrderViewModel) -> Resource<Order?> {
        
        let order = Order(vm)
        
        guard let url = URL.orders else {
            fatalError("URL is not defined!")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding order!")
        }
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = HttpMethod.post
        resource.body = data
        
        return resource
    }
    
    static var all: Resource<[Order]> = {
        
        guard let url = URL.orders else {
            fatalError("URL is not defined!")
        }
        
        return Resource<[Order]>(url: url)
        
    }()
    
}

extension Order {
    
    init?(_ vm: AddCoffeeOrderViewModel) {
        
        
        guard let name = vm.name,
            let email = vm.email,
            let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()),
            let selectedSize = CoffeeSize(rawValue: vm.selectedSize!.lowercased()) else {
                return nil
        }
        
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
        
    }
    
}

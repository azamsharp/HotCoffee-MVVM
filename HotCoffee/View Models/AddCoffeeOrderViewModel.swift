//
//  AddCoffeeOrderViewModel.swift
//  HotCoffee
//
//  Created by Mohammad Azam on 4/15/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation

struct AddCoffeeOrderViewModel: Validatable {

    var name: String?
    var email: String?
    
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] {
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
    
    func validate() -> Bool {

        guard let name = self.name,
              let email = self.email,
              let selectedType = self.selectedType,
              let selectedSize = self.selectedSize else {
            return false
        }

        return !(name.isEmpty || email.isEmpty || selectedType.isEmpty || selectedSize.isEmpty)
    }
}



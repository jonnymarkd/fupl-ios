//
//  Recipe.swift
//  Fupl.v1
//
//  Created by Jon Dean on 21/01/2019.
//  Copyright © 2019 Jon Dean. All rights reserved.
//

import UIKit

class Recipe: Codable {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
}

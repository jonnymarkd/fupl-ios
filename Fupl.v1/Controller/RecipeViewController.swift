//
//  RecipeViewController.swift
//  Fupl.v1
//
//  Created by Jon Dean on 22/01/2019.
//  Copyright © 2019 Jon Dean. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var recipe: Recipe!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = recipe.name
    }
    
}

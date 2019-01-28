//
//  RecipeCell.swift
//  Fupl.v1
//
//  Created by Jon Dean on 22/01/2019.
//  Copyright © 2019 Jon Dean. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func configureForRecipe(_ recipe: Recipe) {
        nameLabel.text = recipe.name
    }
    
}

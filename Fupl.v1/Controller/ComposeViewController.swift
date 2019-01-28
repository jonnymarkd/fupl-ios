//
//  ComposeViewController.swift
//  Fupl.v1
//
//  Created by Jon Dean on 22/01/2019.
//  Copyright © 2019 Jon Dean. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancel() {
        view.endEditing(true)
        dismiss(animated: true)
    }
    
    @IBAction func done() {
        view.endEditing(true)
        
        guard textField.text != "" else {
            dismiss(animated: true)
            return
        }
        
        let recipe = Recipe(id: 0, name: textField.text!)
        
        let session = URLSession(configuration: .default)
        let url = URL(string: "https://api.fupl.tomhv.uk/recipes")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/ld+json", forHTTPHeaderField: "content/type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        let encoder = JSONEncoder()
        var data: Data?
        do {
            data = try encoder.encode(recipe)
        } catch let encodeError as NSError {
            print("Encoder error: \(encodeError)\n")
            return
        }
        request.httpBody = data!
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let _ = data, let response = response as? HTTPURLResponse else {
                print("Recipe not created")
                return
            }
            if response.statusCode == 201 {
                print("Recipe created")
            } else {
                print(response)
            }
            
        }
        task.resume()
    }
    
}

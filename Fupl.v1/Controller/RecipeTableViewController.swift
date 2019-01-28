//
//  ViewController.swift
//  Fupl.v1
//
//  Created by Jon Dean on 21/01/2019.
//  Copyright © 2019 Jon Dean. All rights reserved.
//

import UIKit

class RecipeTableViewController: UIViewController {

    var recipes: [Recipe]?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addTap() {
        performSegue(withIdentifier: "ShowCompose", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "RecipeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RecipeCell")
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case "ShowRecipe":
            let controller = segue.destination as! RecipeViewController
            controller.recipe = sender as? Recipe
        default:
            return
        }
    }

    func loadData() {
        let session = URLSession(configuration: .default)
        let url = URL(string: "https://api.fupl.tomhv.uk/recipes")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    print("No data or statusCode not OK")
                    return
            }
            
            let decoder = JSONDecoder()
            do {
                try self.recipes = decoder.decode([Recipe].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let decodeError as NSError {
                print("Decoder error: \(decodeError)\n")
                return
            }
            
        }
        task.resume()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadData()
        refreshControl.endRefreshing()
    }

}

extension RecipeTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let recipe = recipes![indexPath.row]
        performSegue(withIdentifier: "ShowRecipe", sender: recipe)
    }
    
}

extension RecipeTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipes = recipes else {
            return 0
        }
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        let recipe = recipes![indexPath.row]
        cell.configureForRecipe(recipe)
        return cell
    }
    
}


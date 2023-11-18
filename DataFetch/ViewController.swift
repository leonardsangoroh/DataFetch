//
//  ViewController.swift
//  DataFetch
//
//  Created by Lee Sangoroh on 17/11/2023.
//

import UIKit

class ViewController: UITableViewController {
    ///Array of Petition object
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ///Download data from the Whitehouse petitions server
        ///Convert it to Swift Data object
        ///Convert it to an array of petition instances
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text = "petition.title"
//        cell.detailTextLabel?.text = "petition.body"
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell

    }
    
    func parse(json: Data) {
        ///create instance of JSON Decoder (Dedicated to converting between JSON and Codable objects)
        let decoder = JSONDecoder()
        ///decode() method to convert JSON data into Petitions object
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }


}


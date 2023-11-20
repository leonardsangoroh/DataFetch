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
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }
        else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
            else {
                showError()
            }
        }
        else {
            showError()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(viewCredits))
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showError(){
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check on your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func viewCredits() {
        let ac = UIAlertController(title: "Source", message: "The data displayed is sourced from the 'We the People' API of the Whitehouse ", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default)
        
        ac.addAction(okayAction)
        present(ac, animated: true)
    }


}


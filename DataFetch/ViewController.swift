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
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "We The People"
        
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
                filteredPetitions = petitions
            }
            else {
                showError()
            }
        }
        else {
            showError()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(viewCredits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchWord))
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text = "petition.title"
//        cell.detailTextLabel?.text = "petition.body"
        let petition = filteredPetitions[indexPath.row]
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
    
    @objc func searchWord() {
        let ac = UIAlertController(title: "Search Keyword", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitSearchWord = UIAlertAction(title: "Search", style: .default) { [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else {return}
            
            self?.submit(item)
            
        }
        
        ac.addAction(submitSearchWord)
        present(ac, animated: true)
    }
    
    func submit (_ item:String) {
        filteredPetitions.removeAll(keepingCapacity: true)
        
        for petition in petitions {
            if petition.title.contains(item) {
                filteredPetitions.append(petition)
                tableView.reloadData()
            }
        }
    }
    
}


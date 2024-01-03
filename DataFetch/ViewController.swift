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
        ///GRAND CENTRAL DISPATCH
        /// THREADS
        ///All UI work must occur on the main thread
        ///When accessing any remote resource, slow code, or parallel running code, you should do so on a background thread, not the main one
        ///GCD automatically creates threads for the program and executes code on them in the most efficient way it can
        ///
        ///THREADS QoS queues
        ///1. User Interactive
        ///2. User Initiated
        ///-> Default queue
        ///3. Utility
        ///4. Background
        
        //make all loading code run in the background queue
        //DispatchQueue.global().async { }
        DispatchQueue.global(qos: .userInteractive).async {
            [weak self] in
            if let url = URL(string: urlString) {
                /// Data's contentsOf method was used to download data from the internet
                /// It is a blocking call; meaning it blocks execution of any further code in the method until it has connected to the server and fully downlaoded all the data

                if let data = try? Data(contentsOf: url) {
                    self?.parse(json: data)
                    self?.filteredPetitions = self!.petitions
                }
                else {
                    self!.showError()
                }
            }
            else {
                self?.showError()
            }
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
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }

        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showError(){
        DispatchQueue.main.async { [weak self] in
            
            let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check on your connection and try again", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(ac, animated: true)
        }

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


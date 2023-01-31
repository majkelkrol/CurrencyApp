//
//  ViewController.swift
//  CurrencyApp
//
//  Created by Majkel on 31/01/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var items = [Rate]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetch()
    }
    
    func fetch() {
        guard let url = URL(string: "https://api.nbp.pl/api/exchangerates/tables/A/?format=json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode([CurrencyData].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.items = results.first?.rates ?? []
                        self.tableView.reloadData()
                    }
                } catch {
                    print("error")
                }
            }
        }
        task.resume()
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.currency
        cell.detailTextLabel?.text = String(item.mid)
        return cell
    }
}

//
//  SWTableViewController.swift
//  swapi
//
//  Created by Anton Kuznetsov on 08/12/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

import UIKit


protocol TableViewStrategy {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func viewDidLoad() 
}

class SWViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 0 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { return UITableViewCell() }
        
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    let cellIdentifier = "personCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}


class SWPeopleTableViewController: SWViewController, TableViewStrategy, UITableViewDelegate {
    var people = [SWPerson]()
    var networkManager = SWNetworkManager()
    var loadingSuccedded = true
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadingSuccedded ? people.count : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellIdentifier)
        
        cell.textLabel?.text = loadingSuccedded ? people[indexPath.row].name : "Loading error"
        cell.detailTextLabel?.text = loadingSuccedded ? people[indexPath.row].birth_year : "Please check your connection"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = SWPersonTableViewController()
        destination.person = people[indexPath.row]
        destination.title = destination.person?.name
        navigationController?.pushViewController(destination, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        networkManager.loadFromWeb {[unowned self] (people, error) in
            if error == nil {
                self.people = people
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.loadingSuccedded = false
            }
        }
    }
}

class SWPersonTableViewController: SWViewController, TableViewStrategy {
    var person: SWPerson?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: cellIdentifier)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Name"
            cell.detailTextLabel?.text = person?.name
        case 1:
            cell.textLabel?.text = "Birth year"
            cell.detailTextLabel?.text = person?.birth_year
        case 2:
            cell.textLabel?.text = "Gender"
            cell.detailTextLabel?.text = person?.gender
        case 3:
            cell.textLabel?.text = "Eye color"
            cell.detailTextLabel?.text = person?.eye_color
        default:
            cell.textLabel?.text = "Eye color"
            cell.detailTextLabel?.text = person?.eye_color
        }
        return cell
    }
}


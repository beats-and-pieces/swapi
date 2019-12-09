//
//  SWTableViewController.swift
//  swapi
//
//  Created by Anton Kuznetsov on 08/12/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

import UIKit


class SWPeopleTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: personCellIdentifier)
        return tableView
    }()
    let personCellIdentifier = "personCellIdentifier"
    var people = [SWPerson]()
    var networkManager = SWNetworkManager()
    var loadingSuccedded = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        networkManager.loadFromWeb { (people, error) in
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
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadingSuccedded ? people.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: personCellIdentifier)
        
        cell.textLabel?.text = loadingSuccedded ? people[indexPath.row].name : "Loading error"
        cell.detailTextLabel?.text = loadingSuccedded ? people[indexPath.row].birth_year : "Please check your connection"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = SWPersonViewController(person: people[indexPath.row])
        navigationController?.pushViewController(destination, animated: true)
    }
}


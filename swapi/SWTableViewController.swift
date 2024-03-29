//
//  SWTableViewController.swift
//  swapi
//
//  Created by Anton Kuznetsov on 08/12/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

import UIKit


protocol SWNetworkManagerInputProtocol {
    func people() -> [SWPerson]
    var delegate: SWNetworkManagerOutputProtocol? {get set}
}


class SWPeopleTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: personCellIdentifier)
        return tableView
    }()
    
    let personCellIdentifier = "personCellIdentifier"
    var networkManager: SWNetworkManagerInputProtocol!
    
    init(networkManager: SWNetworkManagerInputProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
        self.networkManager.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.networkManager = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
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
        return networkManager.people().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: personCellIdentifier)
        let person = self.networkManager.people()[indexPath.row]
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.birth_year
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = SWPersonViewController(person: self.networkManager.people()[indexPath.row])
        navigationController?.pushViewController(destination, animated: true)
    }
}

extension SWPeopleTableViewController: SWNetworkManagerOutputProtocol {
    func updateData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


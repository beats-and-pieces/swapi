//
//  SWPersonViewController.swift
//  swapi
//
//  Created by Anton Kuznetsov on 08/12/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

import UIKit


class SWPersonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let person: SWPerson?
    let personCellIdentifier = "personCellIdentifier"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: personCellIdentifier)
        return tableView
    }()
    
    init(person: SWPerson) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
        self.title = person.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        person = nil
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: personCellIdentifier)
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

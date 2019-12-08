//
//  SWAssebly.swift
//  swapi
//
//  Created by Anton Kuznetsov on 08/12/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

import UIKit

class SWAssembly {
    var navigationController: UINavigationController
    init() {
        let networkManager = SWNetworkManager()
        let tableViewController = SWPeopleTableViewController(networkManager: networkManager)
        tableViewController.title = "People of Star Wars"

        navigationController = UINavigationController()
        navigationController.viewControllers = [tableViewController]
    }
    
    func getViewController() -> UIViewController {
        return navigationController
    }
}

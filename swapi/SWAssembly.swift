//
//  SWAssebly.swift
//  swapi
//
//  Created by Anton Kuznetsov on 08/12/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

import UIKit

class SWAssembly {
    static func getViewController() -> UIViewController {
        let navigationController = UINavigationController()
        let tableViewController = SWTableViewController()
        tableViewController.title = "People of Star Wars"
        navigationController.viewControllers = [tableViewController]
        return navigationController
    }
}

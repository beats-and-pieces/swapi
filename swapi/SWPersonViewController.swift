//
//  SWPersonViewController.swift
//  swapi
//
//  Created by Anton Kuznetsov on 08/12/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

import UIKit

class SWPersonViewController: UIViewController {
    
    let person: SWPerson?

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

        // Do any additional setup after loading the view.
    }


}

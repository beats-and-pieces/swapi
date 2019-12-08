//
//  SWPeople.swift
//  swapi
//
//  Created by Anton Kuznetsov on 08/12/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

import Foundation

class SWPeople: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [SWPerson]
}

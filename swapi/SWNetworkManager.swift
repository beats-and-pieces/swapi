//
//  SWNetworkManager.swift
//  swapi
//
//  Created by Anton Kuznetsov on 08/12/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

import Foundation


class SWNetworkManager {
    var urlString = "https://swapi.co/api/people"

    func loadFromWeb(completionHandler: @escaping ([SWPerson], Error?) -> Void) {
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    completionHandler([SWPerson](), error)
                    return }
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(SWPeople.self, from: dataResponse)
                completionHandler(model.results, nil)
                self.urlString = model.next ?? "https://swapi.co/api/people"
            } catch let parsingError {
                completionHandler([SWPerson](), parsingError)
            }
        }
        task.resume()
    }
}

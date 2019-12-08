//
//  SWNetworkManager.swift
//  swapi
//
//  Created by Anton Kuznetsov on 08/12/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

import Foundation

protocol SWNetworkManagerOutputProtocol: class {
    func updateData()
}

class SWNetworkManager: SWNetworkManagerInputProtocol {
    var urlString = "https://swapi.co/api/people"
    var arrayOfPersons = [SWPerson]() {
        didSet {
            delegate?.updateData()
            print("new boss just come")
        }
    }
    
    weak var delegate: SWNetworkManagerOutputProtocol?
    
    func people() -> [SWPerson] {
        return self.arrayOfPersons
    }
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(SWPeople.self, from: dataResponse)
                self.arrayOfPersons += model.results
                self.urlString = model.next ?? "https://swapi.co/api/people"
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    func loadNextPage() {
        getData()
    }
}

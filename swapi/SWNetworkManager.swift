//
//  SWNetworkManager.swift
//  swapi
//
//  Created by Anton Kuznetsov on 08/12/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

import Foundation

class SWNetworkManager {
    func getData() {
        guard let url = URL(string: "https://swapi.co/api/people") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model = try decoder.decode(SWPeople.self, from: dataResponse) //Decode JSON Response Data
                print(model)
            } catch let parsingError {
                print("Error", parsingError)
            }
            
//            do{
//                //here dataResponse received from a network request
//                let jsonResponse = try JSONSerialization.jsonObject(with:
//                    dataResponse, options: [])
//                print(jsonResponse) //Response result
//            } catch let parsingError {
//                print("Error", parsingError)
//            }
        }
        task.resume()
    }
}

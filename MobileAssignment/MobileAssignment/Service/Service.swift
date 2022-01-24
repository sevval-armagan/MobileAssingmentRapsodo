//
//  Service.swift
//  MobileAssignment
//
//  Created by Şevval Armağan on 24.01.2022.
//

import Foundation

class Service {
    
    private let shotsUrl = "http://ec2-18-188-69-79.us-east-2.compute.amazonaws.com:3000/shots"
    
    static let shared = Service()
    
    func getData(completion: @escaping(Response) -> Void)  {
        
        let url = URL(string: shotsUrl)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            if let jsonPetitions = try? decoder.decode(Response.self, from: data) {
                completion(jsonPetitions)
            }
        }
        task.resume()
    }
}

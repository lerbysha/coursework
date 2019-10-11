//
//  APIManager.swift
//  CourseWork
//
//  Created by Артур Гайсин on 03/10/2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//

import Foundation

enum Result {
    case success(value: String)
    case failure(error: Error)
}

class APIManager {
    
    func getData(url:String, completionBlock: @escaping (Result) -> ()) {
        var resp = ""
        guard let statRequestURL = URL(string: url) else { return }
        
        var request = URLRequest(url: statRequestURL)
        request.httpMethod = "GET"
        
        let session = URLSession.shared

        let task = session.dataTask(with: request) { (data, response, error) in
           
    
            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            DispatchQueue.main.async {
                let answer = String(decoding: data!, as: UTF8.self)
                completionBlock(.success(value: answer))
                
                resp = answer
            }
              
        }
        task.resume()

    }
    
    
}

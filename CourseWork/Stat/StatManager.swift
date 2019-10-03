//
//  StatManager.swift
//  CourseWork
//
//  Created by Артур Гайсин on 02/10/2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//

import Foundation
import RealmSwift

class StatManager {
    
    func getStat(url:String){
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
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            do {
                   let json = try JSONSerialization.jsonObject(with: data!, options: [])
                   print(json)
               } catch {
                   print("JSON error: \(error.localizedDescription)")
               }
        }
        task.resume()
    }
    
    
}

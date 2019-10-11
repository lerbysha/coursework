//
//  NumbersApiPresenter.swift
//  CourseWork
//
//  Created by Артур Гайсин on 11.10.2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//

import Foundation

class NumbersApiPresenter {
    
    var answer = ""

    
    var manager = APIManager()
    var view = NumbersViewController()
    
    func getMathStat() -> String {
        let datas = manager.getData(url: "http://numbersapi.com/random/math",completionBlock: {[weak self] (response) in
             switch response {
             case .success(let value):
                self?.answer = value
                
             case .failure(let error):
                print(error)
            }
        })
       return answer
    }
    
    func getDateStat() -> String{
        let datas = manager.getData(url: "http://numbersapi.com/random/date",completionBlock: {[weak self] (response) in
             switch response {
             case .success(let value):
                self?.answer = value
                
             case .failure(let error):
                print(error)
            }
        })
        return answer
        
    }
    
    func getTriviaStat() -> String{
        let datas = manager.getData(url: "http://numbersapi.com/random/trivia",completionBlock: {[weak self] (response) in
             switch response {
             case .success(let value):
                self?.answer = value
                
             case .failure(let error):
                print(error)
            }
        })
        return answer
        
    }
    
    
}

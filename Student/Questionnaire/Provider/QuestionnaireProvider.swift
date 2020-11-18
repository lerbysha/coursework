//
//  QuestionnaireProvider.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import Moya

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

public struct QuestionnaireModel: Decodable {
    var lastName: String
    var firstName: String
    var secondName: String
    var birthDate: String
    var sex: Bool
    var phoneNumber: String
    var citizenship: String
    var typeOfDocument: String
    var shortNumberOfDocument: Int
    var longNumberOfDocument: Int
    var dateOfGetting: String
    var givenByWhom: String
    var code: Int
    var inn: Int
    var insurance: Int
}

protocol QuestionnaireProviderProtocol {
    func emailQuestionnaire(email: String, password: String)
}

final class QuestionnaireProvider: QuestionnaireProviderProtocol {
    let provider = MoyaProvider<QuestionnaireAPI>(plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter),
    logOptions: .verbose))])

    func emailQuestionnaire(email: String, password: String) {
        provider.request(.emailQuestionnaire(email, password)) { result in
            do {
                let response = try result.get()
                let value = try response.map(QuestionnaireModel.self)
                
            } catch {
                let printableError = error as CustomStringConvertible
                print(printableError)
            }
        }
    }
}


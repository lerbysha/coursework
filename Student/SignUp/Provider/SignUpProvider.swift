//
//  SignUpProvider.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

public struct SignUpModel: Decodable {
    var name: String
    var lastName: String
    var secondName: String
    var email: String
    var password: String
    var repeatPassword: String
    var processingOfPersonalData: Bool
}

protocol SignUpProviderProtocol {
    func signUp(signUpModel: SignUpModel, completion: ((AuthModel) -> Void)?)
}

final class SignUpProvider: SignUpProviderProtocol {
    let provider = MoyaProvider<SignUpAPI>(plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter),
    logOptions: .verbose))])

    func signUp(signUpModel: SignUpModel, completion: ((AuthModel) -> Void)? = nil) {
        provider.request(.signUp(signUpModel)) { result in
            do {
                let response = try result.get()
                let value = try response.map(AuthModel.self)
                completion?(value)
            } catch {
                let printableError = error as CustomStringConvertible
                print(printableError)
            }
        }
    }
}

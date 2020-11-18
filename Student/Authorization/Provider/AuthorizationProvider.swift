//
//  AuthorizationProvider.swift
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

struct AuthModel: Decodable {
    var success: Bool
    var error_text: String
    var error_code: Int
    var user_id: Int
    var session_id: Int
    var firstname: String
    var lastname: String
    var middlename: String
}

protocol AuthorizationProviderProtocol {
    func emailAuth(email: String, password: String, completion: ((AuthModel) -> Void)?)
}

final class AuthorizationProvider: AuthorizationProviderProtocol {
    let provider = MoyaProvider<AuthorizationAPI>(plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter),
    logOptions: .verbose))])

    func emailAuth(email: String, password: String, completion: ((AuthModel) -> Void)? = nil) {
        provider.request(.emailAuth(email, password)) { result in
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

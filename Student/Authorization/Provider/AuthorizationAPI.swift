//
//  AuthorizationAPI.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import Moya

public enum AuthorizationAPI {
    case emailAuth(String, String)
}

extension AuthorizationAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "")!
    }

    public var path: String {
        return "/authorization/"
    }

    public var method: Moya.Method {
        return .post
    }

    public var sampleData: Data {
        return Data()
    }

    public var validationType: ValidationType {
        return .successCodes
    }

    public var task: Task {
        switch self {
        case let .emailAuth(email, password):
            return .requestCompositeParameters(bodyParameters: ["p_login": email, "p_password": password], bodyEncoding: JSONEncoding.default, urlParameters: [:])
        }
    }

    public var headers: [String: String]? {
        return [:]
    }
}

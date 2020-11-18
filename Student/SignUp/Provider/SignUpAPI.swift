//
//  SignUpAPI.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import Moya

public enum SignUpAPI {
    case signUp(SignUpModel)
}

extension SignUpAPI: TargetType {
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
        case let .signUp(signUpModel):
            return .requestCompositeParameters(bodyParameters: ["": signUpModel.name, "": signUpModel.lastName, "": signUpModel.secondName, "": signUpModel.email, "": signUpModel.password, "": signUpModel.processingOfPersonalData], bodyEncoding: JSONEncoding.default, urlParameters: [:])
        }
    }

    public var headers: [String: String]? {
        return [:]
    }
}

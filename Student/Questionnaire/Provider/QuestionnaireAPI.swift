//
//  QuestionnaireAPI.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import Moya

public enum QuestionnaireAPI {
    case emailQuestionnaire(String, String)
}

extension QuestionnaireAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://samokatus-backend.cloud.technokratos.com")!
    }

    public var path: String {
        return "/api/auth/sign-in/"
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
        case let .emailQuestionnaire(email, password):
            return .requestCompositeParameters(bodyParameters: ["p_login": email, "p_password": password], bodyEncoding: JSONEncoding.default, urlParameters: [:])
        }
    }

    public var headers: [String: String]? {
        return [:]
    }
}

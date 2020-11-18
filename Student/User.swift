//
//  User.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation

public protocol UserEntity: AnyObject {
    var userID: Int { get set }
    var userSession: String { get set }
    var questionnaireIsFilled: Bool { get set }
    var schoolsIsFilled: Bool { get set }
    var additionalInformationIsFilled: Bool { get set }
    var examsIsFilled: Bool { get set }
    var individualAchievementsIsFilled: Bool { get set }
}

final class User: UserEntity {
    public static let shared = User()
    private let defaults = UserDefaults.standard
    
    var userID: Int {
        get { return defaults.integer(forKey: "userID") }
        set { defaults.set(newValue, forKey: "userID") }
    }
    
    var userSession: String {
        get { return defaults.string(forKey: "userSession") ?? "" }
        set { defaults.set(newValue, forKey: "userSession") }
    }
    
    var questionnaireIsFilled: Bool {
        get { return defaults.bool(forKey: "questionnaireIsFilled")}
        set { defaults.set(newValue, forKey: "questionnaireIsFilled")}
    }
    
    var schoolsIsFilled: Bool {
        get { return defaults.bool(forKey: "schoolsIsFilled")}
        set { defaults.set(newValue, forKey: "schoolsIsFilled")}
    }
    
    var additionalInformationIsFilled: Bool {
        get { return defaults.bool(forKey: "additionalInformationIsFilled")}
        set { defaults.set(newValue, forKey: "additionalInformationIsFilled")}
    }
    
    var examsIsFilled: Bool {
        get { return defaults.bool(forKey: "examsIsFilled")}
        set { defaults.set(newValue, forKey: "examsIsFilled")}
    }
    
    var individualAchievementsIsFilled: Bool {
        get { return defaults.bool(forKey: "individualAchievementsIsFilled")}
        set { defaults.set(newValue, forKey: "individualAchievementsIsFilled")}
    }
}

//
//  ExamsDataFlow.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

public struct Exam {
    public let subject: Subject
    public let examType: ExamType
    public let score: Int
}

public enum ExamType {
    case ege
    case gia
}

public struct Subject {
    public let id: Int
    public let name: String
}

public enum ColorForExam {
    static let pink = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    static let lime = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    static let aqua = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    static let coral = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    static let orchid = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    static let gold = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
}

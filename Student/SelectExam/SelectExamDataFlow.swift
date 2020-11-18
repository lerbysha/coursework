//
//  SelectExamDataFlow.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation

public class SelectExamDataStore {
    public static let shared = SelectExamDataStore()
    
    var selectedExam: String? = nil
    var selectedExamType: String? = nil
}

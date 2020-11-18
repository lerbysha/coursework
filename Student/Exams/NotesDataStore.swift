//
//  NotesDataStore.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation

public class NotesDataStore {
    public static let shared = NotesDataStore()
    
    let notes = [""]
    var exams: [Exam] = []
}

//
//  Task.swift
//  To Do List
//
//  Created by Stefan Crudu on 26.12.2022.
//

import Foundation

struct Task: Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var description: String?
    var deadline: Date
    var isDone: Bool
    
    
    init(name: String, description: String?, deadline:Date, isDone: Bool = false) {
        self.name = name
        self.description = description
        self.deadline = deadline
        self.isDone = isDone
    }
}

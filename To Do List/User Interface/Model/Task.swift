//
//  Task.swift
//  To Do List
//
//  Created by Stefan Crudu on 26.12.2022.
//

import Foundation

struct Task: Codable, Equatable {
    var id: UUID?
    let name: String
    let description: String?
    let deadline: Date
    var isDone: Bool
    
    
    init(id: UUID?, name: String, description: String?, deadline:Date, isDone: Bool = false) {
        self.id = id
        self.name = name
        self.description = description
        self.deadline = deadline
        self.isDone = isDone
    }
}

//
//  TypeOfSorts.swift
//  To Do List
//
//  Created by Stefan Crudu on 31.12.2022.
//

import Foundation

enum TypeOfSorts: CaseIterable {
    case name, date, done
    
    var description: String {
        switch self {
        case .name: return "Name"
        case .date: return "Date"
        case .done: return "Completion"
        }
    }
}

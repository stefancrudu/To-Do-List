//
//  Errors.swift
//  To Do List
//
//  Created by Stefan Crudu on 31.12.2022.
//

import Foundation


enum Errors: Error {
    case noName, nameLimit, descriptionLimit, noDate, dateLimit
    
    var description: ErrorDescription {
        switch self {
        case .noName :
            return ErrorDescription(name: "No name", description: "Please enter a name for your task.", actionLabel: "Ok")
        case .noDate :
            return ErrorDescription(name: "I can't set date", description: "Your date is in the past.", actionLabel: "Ok")
        case .nameLimit :
            return ErrorDescription(name: "Your name is to longer", description: "Please enter a shorter name.", actionLabel: "Ok")
        case .descriptionLimit:
            return ErrorDescription(name: "Your description is to longer", description: "Please enter a shorter description.", actionLabel: "Ok")
        case .dateLimit:
            return ErrorDescription(name: "Your date is to far", description: "Please enter a realistic dealine.", actionLabel: "Ok")
        }
    }
}

struct ErrorDescription {
    let name: String
    let description: String
    let actionLabel: String
}

//
//  AppError.swift
//  To Do List
//
//  Created by Stefan Crudu on 04.01.2023.
//

import Foundation

enum AppError: Error {
    case noList, notDelete, notDone, noSave, noName, nameLimit, descriptionLimit, noDate, dateLimit, defaultError
    
    var description: ErrorDescription {
        switch self {
        case .noList :
            return ErrorDescription(name: "No List", description: "I can't find yout To Do List.", actionLabel: "Ok")
        case .notDelete :
            return ErrorDescription(name: "Ops", description: "I can't delete your task.", actionLabel: "Ok")
        case .notDone :
            return ErrorDescription(name: "Ops", description: "I can't mark your task as done.", actionLabel: "Ok")
        case .noSave:
            return ErrorDescription(name: "Ops", description: "I can't save your task.", actionLabel: "Ok")
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
        case .defaultError:
            return ErrorDescription(name: "Ops", description: "Something it's wrong.", actionLabel: "Ok")
        }
    }
}

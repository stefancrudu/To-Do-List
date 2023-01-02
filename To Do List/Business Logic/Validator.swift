//
//  Validator.swift
//  To Do List
//
//  Created by Stefan Crudu on 30.12.2022.
//

import Foundation

class Validator {
    func validateTask(_ task: Task) throws {
        do {
            try validateName(task.name)
            try validateDescription(task.description)
            try validateDate(task.deadline)
        } catch let error {
            throw error
        }
    }
}

private extension Validator {
    func validateName(_ name: String) throws {
        if name.count > 20 {
            throw Errors.nameLimit
        }
    }
    
    func validateDescription(_ description: String?) throws {
        if description?.count ?? 0 > 40 {
            throw Errors.descriptionLimit
        }
    }
    
    func validateDate(_ date: Date) throws {
        var dateComponent = DateComponents()
        dateComponent.month = 6
        let calendar = Calendar.current
        let maximDate = calendar.date(byAdding: dateComponent, to: Date())
       
        guard let maximDate = maximDate else { throw Errors.noDate }
        guard Calendar.current.compare(Date(), to: date, toGranularity: .day) != .orderedDescending else { throw Errors.noDate }
        guard date < maximDate else { throw Errors.dateLimit }
    }
}

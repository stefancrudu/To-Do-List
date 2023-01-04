//
//  FormPresenter.swift
//  To Do List
//
//  Created by Stefan Crudu on 04.01.2023.
//

import Foundation

protocol FormPresenterProtocol {
    func save(name: String, description:String, deadline: Date) throws
}

class FormPresenter: FormPresenterProtocol {
    private var validator = Validator()
    private var userDefaults = StoreToUserDefaults()
    var task: Task? = nil
    
    func save(name: String, description:String, deadline: Date) throws {
        if task == nil {
            try add(name: name, description: description, deadline: deadline)
        } else {
            try update(name: name, description: description, deadline: deadline)
        }
    }
}
            
private extension FormPresenter {
    func add(name: String, description: String, deadline: Date) throws {
        let task = Task(name: name, description: description, deadline: deadline)
        try validator.validateTask(task)
        try userDefaults.save(with: task)
    }
    
    func update(name: String, description: String, deadline: Date) throws {
        guard var task = task else { throw AppError.defaultError }
        
        task.name = name
        task.description = description
        task.deadline = deadline
        
        try validator.validateTask(task)
        try userDefaults.update(task)
    }
}

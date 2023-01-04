//
//  UserDefaults.swift
//  To Do List
//
//  Created by Stefan Crudu on 31.12.2022.
//

import Foundation

protocol UserDefaultsProtocol {
    func save(with data: Task) throws
    func save(list data: [Task]) throws
    func update(_ task: Task) throws
    func load() throws -> [Task]
}

final class StoreToUserDefaults: UserDefaultsProtocol {
    private var jsonDecoder = JSONDecoder()
    private var jsonEncoder = JSONEncoder()
    
    func save(list data: [Task]) throws {
        do {
            UserDefaults.standard.set( try jsonEncoder.encode(data), forKey: "To-Do-List")
        } catch {
            throw AppError.noSave
        }
    }
    
    func save(with data: Task) throws {
        var loadedList = try load()
        loadedList.append(data)
        try save(list: loadedList)
    }
    
    func update(_ task: Task) throws {
        var loadedList = try load()
        if let indexTask = loadedList.firstIndex(where: {$0.id == task.id}){
            loadedList[indexTask] = task
        }
        try save(list: loadedList)
    }
    
    func load() throws -> [Task] {
        guard let savedList = UserDefaults.standard.object(forKey: "To-Do-List") as? Data else { return [] }
        do {
            return try jsonDecoder.decode([Task].self, from: savedList)
        } catch {
            throw AppError.noList
        }
    }
}

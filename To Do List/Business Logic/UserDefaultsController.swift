//
//  UserDefaults.swift
//  To Do List
//
//  Created by Stefan Crudu on 31.12.2022.
//

import Foundation

protocol UserDefaultsProtocol {
    func store(with data: [Task])
    func load()
}

protocol UserDefaultsDelegate {
    func didLoad(with data: [Task])
}

class UserDefaultsController: UserDefaultsProtocol {
    
    var delegate: UserDefaultsDelegate?
    
    var data: [Task] = [Task]()
    
    func store(with data: [Task]) {
        guard let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else { return }
        let data = TaskList(items: data)
        
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(data) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: appName)
        }
    }
    
    func load() {
        guard let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else { return }
        let defaults = UserDefaults.standard

        if let savedTasks = defaults.object(forKey: appName) as? Data {
            let decoder = JSONDecoder()
            if let loadedTaks = try? decoder.decode(TaskList.self, from: savedTasks) {
                delegate?.didLoad(with: loadedTaks.items)
            }
        }
    }
    
    func decodeData(_ data: String) -> [Task] {
        return [
            Task(id: UUID(), name: "ceva", description: "ce", deadline:  Date())
        ]
    }
}


struct TaskList: Codable {
    var items: [Task]
}

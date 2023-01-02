//
//  Presenter.swift
//  To Do List
//
//  Created by Stefan Crudu on 26.12.2022.
//

import Foundation

protocol PresenterProtocol {
    var formDelegate: PresenterDelegateFormView? { set get }
    func loadData()
    func sort(by sortCondition: TypeOfSorts)
    func save(with task:Task)
    func delete(task: Task)
    func isDone(taskId: UUID)
}

protocol PresenterDelegate: AnyObject {
    func showError(_ error: Errors)
}

protocol PresenterDelegateFormView: PresenterDelegate {
    func didSave()
}

protocol PresenterDelegateMainView: PresenterDelegate {
    func reloadData(with data: [Task])
}

class Presenter: PresenterProtocol {
    var data = [Task]()
    var lastSortCondition: TypeOfSorts = .name
    
    weak var delegate: PresenterDelegateMainView?
    weak var formDelegate: PresenterDelegateFormView?
    
    lazy var userDefaults: UserDefaultsProtocol? = {
        let userDefaults = UserDefaultsController()
        userDefaults.delegate = self
        return userDefaults
    }()
    
    var validator = Validator()
    
    func loadData() {
        userDefaults?.load()
    }
    
    func save(with task:Task) {
        task.id == nil ? add(task: task) : edit(task: task)
    }
    
    func delete(task: Task) {
        data = data.filter { $0.id != task.id}
        reloadData()
    }
    
    func isDone(taskId: UUID) {
        guard let index = data.firstIndex(where: {$0.id == taskId}) else { return }
        data[index].isDone = !data[index].isDone
    }
    
    func sort(by sortCondition: TypeOfSorts) {
        lastSortCondition = sortCondition
        reloadData()
    }
}

private extension Presenter {
    func add(task: Task) {
        var newTask = task
        newTask.id = UUID()
        do {
            try validator.validateTask(newTask)
            data.append(newTask)
            reloadData()
        } catch let error as NSError {
            formDelegate?.showError(error as! Errors)
        }
    }
    
    func edit(task: Task){
        do {
            try validator.validateTask(task)
            if let indexTask = data.firstIndex(where: {$0.id == task.id}){
                data[indexTask] = task
            }
            reloadData()
        } catch let error as NSError {
            formDelegate?.showError(error as! Errors)
        }
    }
    
    func sortData() {
        switch lastSortCondition{
            case .name:
                data.sort(by: {$0.name < $1.name})
                break
            case .date:
                data.sort(by: {$0.deadline.compare($1.deadline) == .orderedAscending})
                break
            case .done:
                data.sort(by: {!$0.isDone && $1.isDone})
                break
        }
    }
    
    func reloadData() {
        sortData()
        if let userDefaults = userDefaults {
            userDefaults.store(with: data)
        }
        
        if let formDelegate = formDelegate {
            formDelegate.didSave()
        }
        
        if let delegate = delegate {
            delegate.reloadData(with: data)
        }
    }
}

extension Presenter: UserDefaultsDelegate {
    func didLoad(with data: [Task]) {
        self.data = data
        delegate?.reloadData(with: data)
    }
}

//
//  Presenter.swift
//  To Do List
//
//  Created by Stefan Crudu on 26.12.2022.
//

import Foundation

protocol PresenterProtocol {
    func loadData()
    func sort(by sortCondition: TypeOfSorts)
    func delete(task: Task)
    func isDone(taskId: UUID)
}

protocol PresenterDelegate: AnyObject {
    func showError(_ error: AppError)
    func reloadData(with data: [Task])
}

class MainPresenter: PresenterProtocol {
    private var data = [Task]()
    private var lastSortCondition: TypeOfSorts = .name
    private var userDefaults  = StoreToUserDefaults()
    weak var delegate: PresenterDelegate?

    func loadData() {
        do {
            data = try userDefaults.load()
            delegate?.reloadData(with: data)
        } catch let error {
            delegate?.showError(error as! AppError)
        }
    }

    func delete(task: Task){
        data = data.filter { $0.id != task.id}
        do {
            try userDefaults.save(list: data)
            delegate?.reloadData(with: data)
        } catch {
            delegate?.showError(AppError.notDelete)
        }
    }
    
    func isDone(taskId: UUID) {
        guard let index = data.firstIndex(where: {$0.id == taskId}) else { return }
        data[index].isDone = !data[index].isDone
        do {
            try userDefaults.save(list: data)
        } catch {
            delegate?.showError(AppError.notDone)
        }
    }
    
    func sort(by sortCondition: TypeOfSorts) {
        lastSortCondition = sortCondition
        sortData()
        delegate?.reloadData(with: data)
    }
}

private extension MainPresenter  {
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
}

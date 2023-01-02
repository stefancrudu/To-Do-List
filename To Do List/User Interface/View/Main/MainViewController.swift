//
//  ViewController.swift
//  To Do List
//
//  Created by Stefan Crudu on 26.12.2022.
//

import UIKit

class MainViewController: UITableViewController {
    private var tasks: [Task] = []
    private lazy var presenter: PresenterProtocol? = {
        let presenter = Presenter()
        presenter.delegate = self
        return presenter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
}

private extension MainViewController {
    func setupNavigationBar() {
        navigationItem.title = "To Do List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(sort))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
    }
    
    @objc func addTask() {
        let form = FormViewController()
        form.presenter = presenter
        navigationController?.show(form, sender: self)
    }
    
    @objc func sort() {
        let sortForm = UIAlertController(title: "Sort by:", message: nil, preferredStyle: .actionSheet)
        
        for type in TypeOfSorts.allCases {
            sortForm.addAction(
                UIAlertAction(title: type.description, style: .default, handler: { _ in
                    self.presenter?.sort(by: type)
                })
            )
        }
        present(sortForm, animated: true)
    }
    
    @objc func isDone(sender: CheckBoxButton) {
        guard let id = sender.idTarget else { return }
        
        presenter?.isDone(taskId: id)
    }
}

extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            _, _, completionHandler in
            
            self.presenter?.delete(task: self.tasks[indexPath.row])
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
            _, _, completionHandler in
            let form = FormViewController()
            form.presenter = self.presenter
            form.task = self.tasks[indexPath.row]
            self.show(form, sender: self)
            completionHandler(true)
        }
               
        editAction.image = UIImage(systemName: "pencil")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false
                
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TaskTableViewCell()
        cell.configure(with: tasks[indexPath.row])
        cell.isDone.addTarget(self, action: #selector(isDone), for: .touchUpInside)
        return cell
    }
}


extension MainViewController:PresenterDelegateMainView {
    func showError(_ error: Errors) {
        
    }
    
    func reloadData(with data: [Task]) {
        tasks = data
        tableView.reloadData()
    }
}


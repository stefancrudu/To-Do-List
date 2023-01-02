//
//  FormViewController.swift
//  To Do List
//
//  Created by Stefan Crudu on 31.12.2022.
//

import UIKit

class FormViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var deadlineDatePiker: UIDatePicker!
    
    var presenter:PresenterProtocol?
    var task: Task? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if task != nil {
            completeForm()
        }
        
        setupNavigationBar()
        setupDelegates()
        setupListener()
    }
}


private extension FormViewController {
    func setupNavigationBar() {        
        navigationItem.setRightBarButton(
            UIBarButtonItem(barButtonSystemItem: .save, target: self,action: #selector(save)),
            animated: true
        )
        navigationItem.rightBarButtonItem?.isEnabled = nameTextField.text?.count ?? 0 > 0
      
    }
    
    func setupDelegates() {
        nameTextField.delegate = self
        descriptionTextField.delegate = self
        presenter?.formDelegate = self
    }
    
    func setupListener() {
        nameTextField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)
    }
    
    func completeForm() {
        guard let task = task else { return }
        nameTextField.text = task.name
        descriptionTextField.text = task.description
        deadlineDatePiker.date = task.deadline
    }
    
    @objc func save() {
        guard let name = nameTextField.text, nameTextField.text!.count > 0 else { showError(.noName); return }
        
        presenter?.save(with: Task(id: task?.id, name: name, description: descriptionTextField.text, deadline: deadlineDatePiker.date))
    }
    
    @objc func nameTextFieldDidChange() {
        guard let text = nameTextField.text else { return }
        
        navigationItem.rightBarButtonItem?.isEnabled = text.count > 0
    }
}

 extension FormViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
             } else {
                textField.resignFirstResponder()
             }
             return false
    }
}


extension FormViewController: PresenterDelegateFormView {
    func didSave() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    func showError(_ error: Errors) {
        let ac = UIAlertController(title: error.description.name, message: error.description.description, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: error.description.actionLabel, style: .default))
        present(ac, animated: true)
    }
    
}

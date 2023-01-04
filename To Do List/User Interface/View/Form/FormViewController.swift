//
//  FormViewController.swift
//  To Do List
//
//  Created by Stefan Crudu on 31.12.2022.
//

import UIKit

class FormViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var deadlineDatePiker: UIDatePicker!
    
    private lazy var presenter:FormPresenterProtocol = {
        let presenter = FormPresenter()
        presenter.task = task
        return presenter
    }()
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
    
    func showError(_ error: AppError) {
         let ac = UIAlertController(title: error.description.name, message: error.description.description, preferredStyle: .alert)
         ac.addAction(UIAlertAction(title: error.description.actionLabel, style: .default))
         present(ac, animated: true)
    }
     
    @objc func save() {
        guard let name = nameTextField.text, nameTextField.text!.count > 0 else { showError(.noName); return }
        do {
            try presenter.save(name: name, description: descriptionTextField.text ?? "", deadline: deadlineDatePiker.date)
           
        } catch let error as NSError {
            print(error.description)
            showError(error as? AppError ?? .defaultError)
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func nameTextFieldDidChange() {
        guard let text = nameTextField.text else { return }
        
        navigationItem.rightBarButtonItem?.isEnabled = text.count > 0
    }
}

extension FormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
             } else {
                textField.resignFirstResponder()
             }
             return false
    }
}

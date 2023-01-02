//
//  CustomTableViewCell.swift
//  To Do List
//
//  Created by Stefan Crudu on 26.12.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    static let identifier = "TaskTableViewCell"
    var task: Task? 
    var name: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15.0)
        
        return label
    }()
    var secondaryText: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 11.0)
        return label
    }()
    
    var deadline: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    var isDone: CheckBoxButton = {
        var button = CheckBoxButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle = .default, reuseIdentifier: String? = "TaskTableViewCell") {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with task: Task) {
        name.text = task.name
        secondaryText.text = task.description
        deadline.text = task.deadline.formatted(date: .numeric, time: .omitted)
        isDone.isChecked = task.isDone
        isDone.idTarget = task.id
    }
}


extension TaskTableViewCell  {
    func setupView() {
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        
        contentView.addSubview(name)
        contentView.addSubview(secondaryText)
        contentView.addSubview(isDone)
        contentView.addSubview(deadline)
        
        NSLayoutConstraint.activate([
            isDone.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            isDone.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            isDone.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            isDone.widthAnchor.constraint(equalToConstant: 34),
            isDone.heightAnchor.constraint(equalToConstant: 34),
            
            name.leadingAnchor.constraint(equalTo: isDone.trailingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: deadline.leadingAnchor, constant: -20),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            
            secondaryText.leadingAnchor.constraint(equalTo: isDone.trailingAnchor, constant: 20),
            secondaryText.trailingAnchor.constraint(equalTo: deadline.leadingAnchor, constant: -20),
            secondaryText.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 2),
            secondaryText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            deadline.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 20),
            deadline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            deadline.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            deadline.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            deadline.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
}

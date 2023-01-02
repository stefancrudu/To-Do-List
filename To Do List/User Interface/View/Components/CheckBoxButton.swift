//
//  CheckBoxButton.swift
//  To Do List
//
//  Created by Stefan Crudu on 26.12.2022.
//

import UIKit

class CheckBoxButton: UIButton {
    var idTarget: UUID?
    let checkedImage = UIImage(systemName: "checkmark.circle.fill")
    let uncheckedImage = UIImage(systemName: "circle")
    
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setBackgroundImage(checkedImage, for: .normal)
                self.tintColor = .systemGreen
            } else {
                self.setBackgroundImage(uncheckedImage, for: .normal)
                self.tintColor = .systemGray
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped(sender: UIButton) {
        isChecked = sender == self ? !isChecked : isChecked
    }
}

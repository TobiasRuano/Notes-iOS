//
//  NONoteView.swift
//  Notes
//
//  Created by Tobias Ruano on 06/07/2021.
//

import UIKit

class NONoteView: UIView {
    
    var updatedAtLabel: UILabel!
    var titleTextField: UITextField!
    var contentTextView: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        updatedAtLabel = UILabel()
        titleTextField = UITextField()
        contentTextView = UITextView()
        
        addSubview(updatedAtLabel)
        addSubview(titleTextField)
        addSubview(contentTextView)
        
        updatedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        updatedAtLabel.textColor = UIColor.secondaryLabel
        updatedAtLabel.text = "4 July 2021, 22:30" // TODO: make it variable
        updatedAtLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            updatedAtLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            updatedAtLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            updatedAtLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            updatedAtLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        titleTextField.placeholder = "Title..."
        titleTextField.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: updatedAtLabel.bottomAnchor, constant: 5),
            titleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            titleTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        contentTextView.backgroundColor = UIColor.systemBackground
        contentTextView.font = UIFont.systemFont(ofSize: 20)
        
        NSLayoutConstraint.activate([
            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 5),
            contentTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            contentTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            contentTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

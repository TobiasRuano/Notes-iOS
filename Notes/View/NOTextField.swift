//
//  NOTextField.swift
//  Notes
//
//  Created by Tobias Ruano on 07/07/2021.
//

import UIKit

class NOTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String, capitalization: UITextAutocapitalizationType, isSecure: Bool) {
        self.init()
        configure(text, capitalization, isSecure)
    }
    
    private func configure(_ text: String, _ capitalization: UITextAutocapitalizationType, _ isSecure: Bool) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .tertiarySystemBackground
        placeholder = text
        layer.cornerRadius = 5
        isSecureTextEntry = isSecure
        autocapitalizationType = capitalization
        autocorrectionType = UITextAutocorrectionType.no
    }
    
}

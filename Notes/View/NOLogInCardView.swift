//
//  NOCardView.swift
//  Notes
//
//  Created by Tobias Ruano on 21/02/2021.
//

import UIKit

class NOLogInCardView: UIView {
    
    private var titleText: UILabel!
    private var mailTextField: NOTextField!
    private var passwordTextField: NOTextField!
    var logInButton: NOButton!
    
    private var spacingConstraint = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewStyle()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewStyle() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
    }
    
    private func configure() {
        titleText = UILabel()
        titleText.text = "Log In"
        titleText.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleText)
        
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(spacingConstraint)),
            titleText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleText.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        mailTextField = NOTextField(text: "Mail", capitalization: .none, isSecure: false)
        self.addSubview(mailTextField)
        NSLayoutConstraint.activate([
            mailTextField.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: CGFloat(spacingConstraint)),
            mailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            mailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            mailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        passwordTextField = NOTextField(text: "Password", capitalization: .none, isSecure: true)
        self.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        logInButton = NOButton(text: "Log In", color: .systemBlue, state: .normal)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logInButton)
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            logInButton.widthAnchor.constraint(equalToConstant: 100),
            logInButton.heightAnchor.constraint(equalToConstant: 40),
            logInButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor)
        ])
    }
    
    func getSize() -> Int {
        let titleSize = 50
        let mailSize = 40
        let passwordSize = 40
        let logInButtonSize = 40
        
        let sum = titleSize + mailSize + passwordSize + logInButtonSize + (spacingConstraint * 2) + 30
        return sum
    }
    
    func getTextFieldsStatus() -> Bool {
        #warning("Use custom tuples + extract to view controller")
        guard let mail = mailTextField.text, mail.isValidEmail() else { return false }
        return passwordTextField.hasText
    }
    
    func getMail() -> String? {
        return mailTextField.text
    }
    
    func getPassword() -> String? {
        return passwordTextField.text
    }
}

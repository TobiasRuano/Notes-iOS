//
//  NORegistrationFormView.swift
//  Notes
//
//  Created by Tobias Ruano on 03/03/2021.
//

import UIKit

class RegistrationFormView: UIView {
    
    private var titleText: UILabel!
    private var mailTextField: NOTextField!
    private var passwordTextField: NOTextField!
    private var secondPasswordTextfield: NOTextField!
    private var nameTextField: NOTextField!
    private var surnameTextField: NOTextField!
    var registerButton: NOButton!
    
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
        titleText.text = "Create Account"
        titleText.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleText)
        
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(spacingConstraint)),
            titleText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleText.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        nameTextField = NOTextField(text: "Name", capitalization: .words, isSecure: false)
        self.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: CGFloat(spacingConstraint)),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        surnameTextField = NOTextField(text: "Surname", capitalization: .words, isSecure: false)
        self.addSubview(surnameTextField)
        NSLayoutConstraint.activate([
            surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            surnameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            surnameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            surnameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        mailTextField = NOTextField(text: "Mail", capitalization: .none, isSecure: false)
        self.addSubview(mailTextField)
        NSLayoutConstraint.activate([
            mailTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 10),
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
        
        secondPasswordTextfield = NOTextField(text: "Re-enter Password", capitalization: .none, isSecure: true)
        self.addSubview(secondPasswordTextfield)
        NSLayoutConstraint.activate([
            secondPasswordTextfield.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            secondPasswordTextfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            secondPasswordTextfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            secondPasswordTextfield.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        registerButton = NOButton(text: "Create Account", color: .systemBlue, state: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: secondPasswordTextfield.bottomAnchor, constant: 10),
            registerButton.widthAnchor.constraint(equalToConstant: 150),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
            registerButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor)
        ])
    }
    
    func getSize() -> Int {
        let titleSize = 50
        let nameSize = 40
        let surnameSize = 40
        let mailSize = 40
        let passwordSize = 40
        let secondPasswordSize = 40
        let logInButtonSize = 40
        
        let sum = titleSize + nameSize + surnameSize + mailSize + passwordSize + secondPasswordSize + logInButtonSize + (spacingConstraint * 2) + 60
        return sum
    }
    
    func getTextFieldsStatus() -> Bool {
        #warning("Check minimun characters password")
        guard let mail = mailTextField.text, mail.isValidEmail() else { return false }
        return passwordTextField.hasText && secondPasswordTextfield.hasText
    }
    
    func getUser() -> User {
        return User(name: nameTextField.text, surname: surnameTextField.text, mail: mailTextField.text)
    }
    
    func getPassword() -> String {
        return passwordTextField.text!
    }
}

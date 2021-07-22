//
//  OnboardingVC.swift
//  Notes
//
//  Created by Tobias Ruano on 20/02/2021.
//

import UIKit

class OnboardingVC: UIViewController {
    
    private var logInCardView: NOLogInCardView!
    private var registerCardView: NORegisterCardView!
    
    private var networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        style()
    }
    
    private func style() {
        logInCardView = NOLogInCardView()
        logInCardView.dropShadow()
        view.addSubview(logInCardView)
        logInCardView.logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        let logInHeight = logInCardView.getSize()
        NSLayoutConstraint.activate([
            logInCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logInCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logInCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logInCardView.heightAnchor.constraint(equalToConstant: CGFloat(logInHeight))
        ])
        
        registerCardView = NORegisterCardView()
        view.addSubview(registerCardView)
        registerCardView.dropShadow()
        registerCardView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        let registerHeight = registerCardView.getSize()
        NSLayoutConstraint.activate([
            registerCardView.topAnchor.constraint(equalTo: logInCardView.bottomAnchor, constant: 50),
            registerCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerCardView.heightAnchor.constraint(equalToConstant: CGFloat(registerHeight))
        ])
    }
    
    @objc func logIn(_ sender: Any) {
        if getTextFieldsStatus() {
            let mail = logInCardView.getMail()
            let pass = logInCardView.getPassword()
            
            networkManager.logIn(mail: mail!, password: pass!) { (result) in
                switch result {
                case .success(let user):
                    DispatchQueue.main.sync {
                        let vc = NOTabBarController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.alert(title: "Error!", message: "There's been an error while trying to Login.  \(error)")
                    }
                }
            }
        }
    }
    
    private func getTextFieldsStatus() -> Bool {
        let mail = logInCardView.getMail()
        let password = logInCardView.getPassword()
        
        switch (mail, password) {
        case let (mail?, password?):
            print("success")
            return true
        case let (mail?, nil):
            print("No password")
            return false
        case let (nil, password?):
            print("No email")
            return false
        case (nil, nil):
            print("Mail and password missing")
            return false
        }
    }
    
    @objc func register(_ sender: Any) {
        let vc = RegisterVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

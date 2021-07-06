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
        view.addSubview(logInCardView)
        logInCardView.logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        let logInHeight = logInCardView.getSize()
        NSLayoutConstraint.activate([
            logInCardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            logInCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logInCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logInCardView.heightAnchor.constraint(equalToConstant: CGFloat(logInHeight))
        ])
        
        registerCardView = NORegisterCardView()
        view.addSubview(registerCardView)
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
        let value = logInCardView.getTextFieldsStatus()
        
        if value {
            let mail = logInCardView.getMail()
            let pass = logInCardView.getPassword()
            
            networkManager.logIn(mail: mail, password: pass) { (result) in
                switch result {
                case .success(let user):
                    DispatchQueue.main.sync {
                        let vc = HomeViewController()
                        vc.modalPresentationStyle = .fullScreen
                        vc.setUser(userToSet: user)
                        self.present(vc, animated: true)
                    }
                case .failure(let error):
                    print(error)
                    #warning("Implement an alert with the corresponding error.")
                }
            }
        }
    }
    
    @objc func register(_ sender: Any) {
        let vc = RegisterVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

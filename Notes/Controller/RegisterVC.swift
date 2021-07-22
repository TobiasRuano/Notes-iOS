//
//  RegisterVC.swift
//  Notes
//
//  Created by Tobias Ruano on 03/03/2021.
//

import UIKit

class RegisterVC: UIViewController {
    
    private var registrationFormView: RegistrationFormView!
    private let networkManager = NetworkManager.shared
    
    var user: User!
    var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        style()
    }
    
    private func style() {
        registrationFormView = RegistrationFormView()
        registrationFormView.dropShadow()
        view.addSubview(registrationFormView)
        registrationFormView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        let logInHeight = registrationFormView.getSize()
        NSLayoutConstraint.activate([
            registrationFormView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            registrationFormView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registrationFormView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registrationFormView.heightAnchor.constraint(equalToConstant: CGFloat(logInHeight))
        ])
    }
    
    @objc func register(_ sender: Any) {
        user = registrationFormView.getUser()
        password = registrationFormView.getPassword()
        networkManager.registerUser(user: user, password: password) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.sync {
                    self.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.alert(title: "Error!", message: "There's been an error while trying to create the account.  \(error)")
                }
            }
        }
    }
    
}

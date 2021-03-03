//
//  NORegisterCardView.swift
//  Notes
//
//  Created by Tobias Ruano on 03/03/2021.
//

import UIKit

class NORegisterCardView: UIView {
    
    private var titleText: UILabel!
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
    }
    
    private func configure() {
        titleText = UILabel()
        titleText.text = "Register"
        titleText.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleText)
        
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(spacingConstraint)),
            titleText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleText.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        registerButton = NOButton(text: "Register", color: .systemRed, state: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 10),
            registerButton.widthAnchor.constraint(equalToConstant: 100),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
            registerButton.centerXAnchor.constraint(equalTo: titleText.centerXAnchor)
        ])
    }
    
    func getSize() -> Int {
        let titleSize = 50
        let registerButtonSize = 40
        
        let sum = titleSize + registerButtonSize + spacingConstraint + 20
        return sum
    }
}

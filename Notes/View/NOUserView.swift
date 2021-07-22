//
//  NOUserView.swift
//  Notes
//
//  Created by Tobias Ruano on 07/07/2021.
//

import UIKit

class NOUserView: UIView {
    
    var imageView: UIImageView!
    var nameLabel: UILabel!
    var editProfileButton: NOButton!
    var logOutButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(name: String) {
        self.init()
        configure(name: name)
    }
    
    private func configure(name: String) {
        imageView = UIImageView()
        nameLabel = UILabel()
        editProfileButton = NOButton(text: "Edit profile", color: .systemBlue, state: .normal)
        logOutButton = UIButton()
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(editProfileButton)
        addSubview(logOutButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.dropShadow()
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 180),
            imageView.heightAnchor.constraint(equalToConstant: 180),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        nameLabel.text = name
        nameLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        nameLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        editProfileButton.dropShadow()
        #warning("Top anchor needs to be changed")
        NSLayoutConstraint.activate([
            editProfileButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),
            editProfileButton.widthAnchor.constraint(equalToConstant: 240),
            editProfileButton.heightAnchor.constraint(equalToConstant: 45),
            editProfileButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
}

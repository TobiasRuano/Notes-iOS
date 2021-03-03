//
//  NOButton.swift
//  Notes
//
//  Created by Tobias Ruano on 21/02/2021.
//

import UIKit

class NOButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String, color: UIColor, state: UIControl.State) {
        self.init()
        configure(string: text, color: color, state: state)
    }
    
    private func configure(string: String, color: UIColor, state: UIControl.State) {
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(string, for: .normal)
        backgroundColor = color
    }
}

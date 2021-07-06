//
//  NotesCell.swift
//  Notes
//
//  Created by Tobias Ruano on 04/03/2021.
//

import UIKit

class NotesCell: UITableViewCell {
    
    static let reuseID = "NotesCell"
    var titleLabel: UILabel!
    var contentLabel: UILabel!
    var dateLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(note: Note) {
        titleLabel.text = note.title
        contentLabel.text = note.content
        dateLabel.text = note.createdAt
    }
    
    private func configure() {
        titleLabel = UILabel()
        addSubview(titleLabel)
        contentLabel = UILabel()
        addSubview(contentLabel)
        dateLabel = UILabel()
        addSubview(dateLabel)
        
        accessoryType = .disclosureIndicator
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            titleLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: 10),
            
            contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            contentLabel.heightAnchor.constraint(equalToConstant: 40),
            contentLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
            contentLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: 10),
            
            dateLabel.heightAnchor.constraint(equalToConstant: 40),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        contentLabel.textColor = UIColor.secondaryLabel
    }
}

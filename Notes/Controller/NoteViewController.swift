//
//  NoteViewController.swift
//  Notes
//
//  Created by Tobias Ruano on 06/07/2021.
//

import UIKit

class NoteViewController: UIViewController {
    
    var contentView: NONoteView!
    var note: Note!
    
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        if note != nil {
            contentView.titleTextField.text = note.title
            contentView.contentTextView.text = note.content
            contentView.updatedAtLabel.text = Date().getDateFormatted(stringDate: note.updatedAt!)
        }
    }
    
    private func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = false
        let saveNote = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
        navigationItem.rightBarButtonItem = saveNote
        view.backgroundColor = .systemBackground
        
        contentView = NONoteView()
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func saveNote() {
        if checkTextFields() {
            let title = contentView.titleTextField.text
            var content = ""
            if let contentText = contentView.contentTextView.text {
                content = contentText
            }
            if note != nil {
                if note.title != title || note.content != content {
                    note.title = title
                    note.content = content
                    save(note: note)
                }
            } else {
                let newNote = Note(id: nil, title: title, createdAt: nil, updatedAt: nil, content: content, userId: nil)
                save(note: newNote)
            }
        }
    }
    
    private func save(note: Note) {
        networkManager.saveNote(note: note) { (result) in
            switch result {
            case .success(let note):
                DispatchQueue.main.async {
                    print(note.title)
                }
            case .failure(let error):
                print("Problema al guardar")
                #warning("Poner una alerta de error")
            }
        }
    }
    
    private func checkTextFields() -> Bool {
        return contentView.titleTextField.hasText
    }
}

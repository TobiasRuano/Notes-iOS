//
//  NoteViewController.swift
//  Notes
//
//  Created by Tobias Ruano on 06/07/2021.
//

import UIKit

protocol NoteDelegate: AnyObject {
    func getData( _ note: Note)
}

class NoteViewController: UIViewController {
    
    let networkManager = NetworkManager.shared
    weak var delegate: NoteDelegate?
    var contentView: NONoteView!
    var note: Note!
    var dataHasBeenUpdated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        if note != nil {
            contentView.titleTextField.text = note.title
            contentView.contentTextView.text = note.content
            contentView.updatedAtLabel.text = Date().getDateFormatted(stringDate: note.updatedAt!)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let delegate = self.delegate, dataHasBeenUpdated {
            delegate.getData(note)
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
                    self.note = note
                    self.dataHasBeenUpdated = true
                    self.alert(message: "Note succesfully saved!")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.alert(title: "Error!", message: "There's been an error while trying to save the note. Please try again.  \(error)")
                }
            }
        }
    }
    
    private func checkTextFields() -> Bool {
        return contentView.titleTextField.hasText
    }
}

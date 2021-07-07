//
//  ViewController.swift
//  Notes
//
//  Created by Tobias Ruano on 20/02/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var user: User!
    private var userNotes: [Note] = []
    private var networkManager = NetworkManager.shared
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getNotesFromAPI()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Notes"
        let newNote = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newNote))
        navigationItem.rightBarButtonItem = newNote
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(NotesCell.self, forCellReuseIdentifier: NotesCell.reuseID)
    }
    
    @objc func newNote() {
        let noteVC = NoteViewController()
        navigationController?.pushViewController(noteVC, animated: true)
    }
    
    func setUser(userToSet: User) {
        user = User(id: userToSet.id!, name: userToSet.name!, surname: userToSet.surname!, mail: userToSet.mail!)
    }
    
    private func getNotesFromAPI() {
        networkManager.getNotes() { (result) in
            switch result {
            case .success(let notes):
                #warning("sort array by date")
                self.userNotes = notes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesCell.reuseID) as! NotesCell
        cell.titleLabel.text = userNotes[indexPath.row].title
        cell.contentLabel.text = userNotes[indexPath.row].content
        cell.dateLabel.text = Date().getDateFormatted(stringDate: userNotes[indexPath.row].updatedAt!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteVC = NoteViewController()
        noteVC.note = userNotes[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(noteVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            deleteNote(index: indexPath)
        default:
            break
        }
    }
    
    private func deleteNote(index: IndexPath) {
        let note = userNotes[index.row]
        networkManager.deleteNote(note: note) { (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.userNotes.remove(at: index.row)
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

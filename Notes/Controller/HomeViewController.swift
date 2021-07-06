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
        self.view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Notes"
        configureTableView()
        getNotesFromAPI()
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
    
    func setUser(userToSet: User) {
        user = User(id: userToSet.id!, name: userToSet.name!, surname: userToSet.surname!, mail: userToSet.mail!)
    }
    
    private func getNotesFromAPI() {
        networkManager.getNotes() { (result) in
            switch result {
            case .success(let notes):
                #warning("sort array by date")
                self.userNotes = notes
                print(notes)
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
        #warning("Correct date format")
        cell.dateLabel.text = userNotes[indexPath.row].createdAt
        return cell
    }
    	
}

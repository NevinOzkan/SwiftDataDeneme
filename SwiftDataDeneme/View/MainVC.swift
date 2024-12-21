//
//  MainVC.swift
//  SwiftDataDeneme
//
//  Created by Nevin Özkan on 21.12.2024.
//

import UIKit
import SwiftData

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var container: ModelContainer?
    var users: [User] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadUsers()
        addSampleUsers()
    }
    
    private func setupUI() {
        let nib = UINib(nibName: "MainCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MainCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func loadUsers() {
        container = try? ModelContainer(for: User.self)
        
        let descriptor = FetchDescriptor<User>()
        let fetchedUsers = (try? container?.mainContext.fetch(descriptor)) ?? []
        
        users = fetchedUsers
        tableView.reloadData()
    }
    
    private func addSampleUsers() {
        let sampleUsers = [
            User(name: "Alice", birthYear: 1990),
            User(name: "Bob", birthYear: 1985),
            User(name: "Charlie", birthYear: 2000)
        ]
        
        let context = container?.mainContext
        for user in sampleUsers {
            try? context?.insert(user)
        }
        
        try? context?.save()
        
        loadUsers()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell else {
            return UITableViewCell()
        }
        
        let user = users[indexPath.row]
        cell.textLabel?.text = "\(user.name) - \(user.birthYear)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}

//
//  TableViewController.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit

final class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
}

// MARK: UITableViewDataSource
extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let even = indexPath.row % 2 == 0
        if even {
            tableViewCell.setup(PullRequestView(title: "PR #\(indexPath.row) - Testes do componente", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras gravida vulputate dictum. Cras rhoncus varius fringilla.", date: "15/01/2025", authorName: "Meu Nome Muito Legal", authorAvatarURL: URL(string: "https://avatars.githubusercontent.com/u/116613733?v=4"), state: nil))
        } else {
            tableViewCell.setup(RepositoryView(userName: "Meu Nome Muito Legal", avatarURL: URL(string: "https://avatars.githubusercontent.com/u/35151645?v=4"), repoName: "OpenRepo\(indexPath.row)", repoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras gravida vulputate dictum. Cras rhoncus varius fringilla. Aenean mattis dolor eget nisl tristique fermentum ac in risus. Praesent ipsum dui, semper quis euismod vitae, elementum at sapien. Donec in posuere ipsum, quis laoreet ipsum. Nullam suscipit velit odio, a accumsan augue euismod id. Quisque condimentum purus sapien, eu pellentesque tellus rhoncus non. Fusce venenatis consequat sem, et lobortis tellus dapibus quis.", forksCount: "503", starsCount: "56.775"))
        }
        return tableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

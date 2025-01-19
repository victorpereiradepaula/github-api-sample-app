//
//  RepositoriesTableViewController.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 17/01/25.
//

import UIKit

protocol RepositoriesTableViewDelegate: PaginatedTableViewDelegate {
    func goToRullRequests(_ repositoryFullName: String)
}

final class RepositoriesTableViewController: PaginatedTableViewController<RepositoriesViewModel>, RepositoriesTableViewDelegate {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        tableViewCell.setup(RepositoryView(viewModel.items[indexPath.row]))
        return tableViewCell
    }
    
    func goToRullRequests(_ repositoryFullName: String) {
        let viewModel = PullRequestsViewModel(repositoryFullName)
        let viewController = PullRequestsTableViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//
//  RepositoriesTableViewController.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 17/01/25.
//

import UIKit

final class RepositoriesTableViewController: TableViewController<RepositoriesViewModel> {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        tableViewCell.setup(RepositoryView(viewModel.items[indexPath.row]))
        return tableViewCell
    }
}

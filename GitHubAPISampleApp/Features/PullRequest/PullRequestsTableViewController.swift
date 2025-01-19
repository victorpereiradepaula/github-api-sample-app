//
//  PullRequestsTableViewController.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 17/01/25.
//

import UIKit

protocol PullRequestsTableViewDelegate: PaginatedTableViewDelegate {
    func gotToPullRequestDetail(_ url: URL)
}

final class PullRequestsTableViewController: PaginatedTableViewController<PullRequestsViewModel>, PullRequestsTableViewDelegate {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        tableViewCell.setup(PullRequestView(viewModel.items[indexPath.row]))
        return tableViewCell
    }
    
    func gotToPullRequestDetail(_ url: URL) {
        present(WKWebViewController(urlRequest: URLRequest(url: url)), animated: true)
    }
}

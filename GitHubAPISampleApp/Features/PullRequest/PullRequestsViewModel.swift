//
//  PullRequestsViewModel.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 17/01/25.
//

import UIKit

final class PullRequestsViewModel: TableViewModelProtocol {
    typealias T = PullRequest
    
    weak var delegate: PullRequestsTableViewDelegate?
    
    let repositoryFullName: String
    var currentPage = 1
    var items: [PullRequest] = [] {
        didSet {
            delegate?.reloadData()
        }
    }
    
    init(_ repositoryFullName: String) {
        self.repositoryFullName = repositoryFullName
        fetchPullRequests()
    }
    
    var stringUrl: String {
        "https://api.github.com/repos/\(repositoryFullName)/pulls?state=all&per_page=10&page=\(currentPage)"
    }
    
    var title: String {
        repositoryFullName
    }
    
    var numberOfItems: Int {
        items.count
    }
    
    func fetchPullRequests() {
        Network.request(type: [PullRequest].self, stringUrl: stringUrl) { [weak self] result in
            switch result {
            case .success(let pullRequests):
                self?.items = pullRequests
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        delegate?.gotToPullRequestDetail(items[indexPath.row].htmlUrl)
    }
}

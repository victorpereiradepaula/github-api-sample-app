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
    var isLoading = true
    var isLastPage = false
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
        "https://api.github.com/repos/\(repositoryFullName)/pulls?state=all&per_page=\(itensPerPage)&page=\(currentPage)"
    }
    
    var title: String {
        repositoryFullName
    }
    
    var numberOfItems: Int {
        items.count
    }
    
    func canGetNextPage(_ willDisplayRow: Int) -> Bool {
        !isLoading && willDisplayRow == items.count - 1 && !isLastPage
    }
    
    func getNextPageIfNeeded(at indexPath: IndexPath) {
        print(canGetNextPage(indexPath.row))
        guard canGetNextPage(indexPath.row) else { return }
        currentPage += 1
        fetchPullRequests()
    }
    
    func fetchPullRequests() {
        self.isLoading = true
        Network.request(type: [PullRequest].self, stringUrl: stringUrl) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let pullRequests):
                if pullRequests.isEmpty {
                    self?.isLastPage = true
                } else {
                    self?.items.append(contentsOf: pullRequests)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        delegate?.gotToPullRequestDetail(items[indexPath.row].htmlUrl)
    }
}

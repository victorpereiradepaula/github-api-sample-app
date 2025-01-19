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
    
    private let repositoryFullName: String
    private let service: NetworkService
    
    var emptyFeedbackMessage: String = "Nenhum pull request encontrado."
    var isLoading = true {
        didSet {
            showFeedbackIfNeeded()
        }
    }
    var isLastPage = false
    var currentPage = 1
    var items: [T] = [] {
        didSet {
            delegate?.reloadData()
        }
    }
    
    init(_ repositoryFullName: String, service: NetworkService = NetworkService()) {
        self.repositoryFullName = repositoryFullName
        self.service = service
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
    
    func viewDidLoad() {
        fetchPullRequests()
    }
    
    func showFeedback(_ type: FeedbackType) {
        delegate?.showFeedback(type)
    }
    
    func removeFeedback() {
        delegate?.removeFeedback()
    }
    
    func canGetNextPage(_ willDisplayRow: Int) -> Bool {
        !isLoading && willDisplayRow == items.count - 1 && !isLastPage
    }
    
    func getNextPageIfNeeded(at indexPath: IndexPath) {
        guard canGetNextPage(indexPath.row) else { return }
        currentPage += 1
        fetchPullRequests()
    }
    
    func fetchPullRequests() {
        self.isLoading = true
        service.request(type: [PullRequest].self, stringUrl: stringUrl) { [weak self] result in
            switch result {
            case .success(let pullRequests):
                if pullRequests.isEmpty {
                    self?.isLastPage = true
                } else {
                    self?.items.append(contentsOf: pullRequests)
                }
                self?.isLoading = false
            case .failure(let error):
                self?.showFeedback(.error(error.localizedDescription))
            }
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        delegate?.gotToPullRequestDetail(items[indexPath.row].htmlUrl)
    }
}

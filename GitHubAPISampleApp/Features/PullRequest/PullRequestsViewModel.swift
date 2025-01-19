//
//  PullRequestsViewModel.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 17/01/25.
//

import UIKit

final class PullRequestsViewModel: PaginatedTableViewModelProtocol {
    typealias T = PullRequest
    
    weak var delegate: PullRequestsTableViewDelegate?
    
    private let repositoryFullName: String
    private let service: NetworkService
    
    let emptyFeedbackMessage = "Nenhum pull request encontrado."
    var state: ListState = .loading
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
    }
    
    var path: String {
        "repos/\(repositoryFullName)/pulls?state=all"
    }
    
    var title: String {
        repositoryFullName
    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    func showFeedback(_ type: FeedbackType) {
        delegate?.showFeedback(type)
    }
    
    func removeFeedback() {
        delegate?.removeFeedback()
    }
    
    func canGetNextPage(_ willDisplayRow: Int) -> Bool {
        state != .loading && willDisplayRow == items.count - 1 && !isLastPage
    }
    
    func fetchData() {
        setStateBeforeRequest()
        let stringUrl = UrlManager.createUrl(path, itensPerPage: itensPerPage, currentPage: currentPage)
        service.request(type: [PullRequest].self, stringUrl: stringUrl) { [weak self] result in
            guard let self = self else { return }
            var error: APIError?
            switch result {
            case .success(let pullRequests):
                if pullRequests.isEmpty {
                    self.isLastPage = true
                } else {
                    self.items.append(contentsOf: pullRequests)
                }
            case .failure(let apiError):
                error = apiError
            }
            setStateAfterRequest(error)
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        delegate?.gotToPullRequestDetail(items[indexPath.row].htmlUrl)
    }
}

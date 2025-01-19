//
//  RepositoriesViewModel.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit

final class RepositoriesViewModel: PaginatedTableViewModelProtocol {
    typealias T = Repository
    typealias V = RepositoriesTableViewDelegate
    
    weak var delegate: V?
    
    private let service: NetworkService
    
    let title = "Repositórios Swift"
    let path = "search/repositories?q=language:Swift&sort=stars"
    let emptyFeedbackMessage = "Nenhum repositório encontrado."
    
    var state: ListState = .loading
    var currentPage = 1
    var totalItens: Int = 0
    
    var lastPage: Int {
        let roundedPages = ceil(Double(totalItens) / Double(itensPerPage))
        return Int(roundedPages)
    }
    
    var items: [Repository] = [] {
        didSet {
            delegate?.reloadData()
        }
    }
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
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
    
    func didSelectItem(at indexPath: IndexPath) {
        delegate?.goToRullRequests(items[indexPath.row].fullName)
    }
    
    func canGetNextPage(_ willDisplayRow: Int) -> Bool {
        state != .loading && willDisplayRow == items.count - 1 && currentPage < lastPage
    }
    
    func fetchData() {
        setStateBeforeRequest()
        let stringUrl = UrlManager.createUrl(path, itensPerPage: itensPerPage, currentPage: currentPage)
        service.request(type: Repositories.self, stringUrl: stringUrl) { [weak self] result in
            guard let self else { return }
            var error: APIError?
            switch result {
            case .success(let repositories):
                self.totalItens = repositories.totalCount
                self.items.append(contentsOf: repositories.items)
            case .failure(let apiError):
                error = apiError
            }
            self.setStateAfterRequest(error)
        }
    }
}

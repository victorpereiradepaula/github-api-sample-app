//
//  RepositoriesViewModel.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit

final class RepositoriesViewModel: TableViewModelProtocol {
    typealias T = Repository
    typealias V = RepositoriesTableViewDelegate
    
    weak var delegate: V?
    
    private let service: NetworkService
    
    var title = "Repositórios Swift"
    var emptyFeedbackMessage: String = "Nenhum repositório encontrado."
    var state: ListState = .loading {
        didSet {
            showFeedbackIfNeeded()
        }
    }
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
    
    var stringUrl: String {
        "https://api.github.com/search/repositories?q=language:Swift&sort=stars&per_page=\(itensPerPage)&page=\(currentPage)"
    }
    
    var numberOfItems: Int {
        items.count
    }
    
    func viewDidLoad() {
        fetchRepositories()
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
    
    func getNextPageIfNeeded(at indexPath: IndexPath) {
        guard canGetNextPage(indexPath.row) else { return }
        currentPage += 1
        fetchRepositories()
    }
    
    func fetchRepositories() {
        state = .loading
        service.request(type: Repositories.self, stringUrl: stringUrl) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let repositories):
                self.totalItens = repositories.totalCount
                self.items.append(contentsOf: repositories.items)
                self.state = self.getStateAfterResponse()
            case .failure(let error):
                self.state = .error(message: error.localizedDescription)
            }
        }
    }
}

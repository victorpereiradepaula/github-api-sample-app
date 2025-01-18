//
//  RepositoriesViewModel.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit

final class RepositoriesViewModel: TableViewModelProtocol {
    typealias T = Repository
    
    weak var delegate: RepositoriesTableViewDelegate?
    
    var title = "Repositórios Swift"
    var isLoading = true
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
    
    init() {
        fetchRepositories()
    }
    
    var stringUrl: String {
        "https://api.github.com/search/repositories?q=language:Swift&sort=stars&per_page=\(itensPerPage)&page=\(currentPage)"
    }
    
    var numberOfItems: Int {
        items.count
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        delegate?.goToRullRequests(items[indexPath.row].fullName)
    }
    
    func canGetNextPage(_ willDisplayRow: Int) -> Bool {
        !isLoading && willDisplayRow == items.count - 1 && currentPage < lastPage
    }
    
    func getNextPageIfNeeded(at indexPath: IndexPath) {
        guard canGetNextPage(indexPath.row) else { return }
        currentPage += 1
        fetchRepositories()
    }
    
    func fetchRepositories() {
        self.isLoading = true
        Network.request(type: Repositories.self, stringUrl: stringUrl) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let repositories):
                self?.totalItens = repositories.totalCount
                self?.items.append(contentsOf: repositories.items)
            case .failure(let error):
                print(error)
            }
        }
    }
}

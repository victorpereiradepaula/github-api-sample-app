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
    var currentPage = 1
    
    var items: [Repository] = [] {
        didSet {
            delegate?.reloadData()
        }
    }
    
    init() {
        fetchRepositories()
    }
    
    var stringUrl: String {
        "https://api.github.com/search/repositories?q=language:Swift&sort=stars&per_page=10&page=\(currentPage)"
    }
    
    var numberOfItems: Int {
        items.count
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        delegate?.goToRullRequests(items[indexPath.row].fullName)
    }
    
    func fetchRepositories() {
        Network.request(type: Repositories.self, stringUrl: stringUrl) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.items = repositories.items
            case .failure(let error):
                print(error)
            }
        }
    }
}

//
//  RepositoriesViewModel.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import Alamofire

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
    
    var repositoriesPath: String {
        "https://api.github.com/search/repositories?q=language:Swift&sort=stars&per_page=10&page=\(currentPage)"
    }
    
    var numberOfItems: Int {
        items.count
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        delegate?.goToRullRequests(items[indexPath.row].fullName)
    }
    
    func fetchRepositories() {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(repositoriesPath).responseDecodable(of: Repositories.self, decoder: jsonDecoder) { [weak self] response in
            switch response.result {
            case .success(let repositories):
                self?.items = repositories.items
            case .failure(let error):
                if let data = response.data, let apiError = try? jsonDecoder.decode(APIError.self, from: data) {
                    debugPrint(apiError)
                } else {
                    debugPrint(error)
                }
            }
        }
    }
}

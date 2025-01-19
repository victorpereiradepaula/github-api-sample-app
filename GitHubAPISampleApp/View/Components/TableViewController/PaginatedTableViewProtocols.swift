//
//  PaginatedTableViewProtocols.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 17/01/25.
//

import UIKit

protocol PaginatedTableViewDelegate: AnyObject {
    func reloadData()
    func showFeedback(_ type: FeedbackType)
    func removeFeedback()
}

protocol PaginatedTableViewModelProtocol: AnyObject {
    associatedtype T: Codable
    var title: String { get }
    var numberOfItems: Int { get }
    var items: [T] { get }
    var state: ListState { get set }
    var emptyFeedbackMessage: String { get }
    var itensPerPage: Int { get }
    var currentPage: Int { get set }
    func fetchData()
    func canGetNextPage(_ willDisplayRow: Int) -> Bool
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
    func getNextPageIfNeeded(at indexPath: IndexPath)
    func showFeedbackIfNeeded()
    func setStateBeforeRequest()
    func setStateAfterRequest(_ error: APIError?)
    func showFeedback(_ type: FeedbackType)
    func removeFeedback()
}

extension PaginatedTableViewModelProtocol {
    var itensPerPage: Int { 10 }
    
    var numberOfItems: Int {
        items.count
    }
    
    func getStateBeforeRequest() -> ListState {
        if items.isEmpty {
            return .loading
        }
        return .loaded
    }
    
    func setStateBeforeRequest() {
        if items.isEmpty {
            self.state = .loading
        } else {
            self.state = .loaded
        }
        showFeedbackIfNeeded()
    }
    
    func setStateAfterRequest(_ error: APIError?) {
        if items.isEmpty {
            if let error = error {
                self.state = .error(message: error.localizedDescription)
            } else {
                self.state = .empty(message: emptyFeedbackMessage)
            }
        } else {
            self.state = .loaded
        }
        showFeedbackIfNeeded()
    }
    
    func getNextPageIfNeeded(at indexPath: IndexPath) {
        guard canGetNextPage(indexPath.row) else { return }
        currentPage += 1
        fetchData()
    }
    
    func showFeedbackIfNeeded() {
        switch state {
        case .loading:
            showFeedback(.loading)
        case .loaded:
            removeFeedback()
        case .empty(let message):
            showFeedback(.message(message, systemImageName: "text.page.slash", imageColor: .gray))
        case .error(let message):
            showFeedback(.message(message, systemImageName: "exclamationmark.circle", imageColor: .systemRed, action: .init(title: "Tentar novamente", action: { [weak self] in
                self?.fetchData()
            })))
        }
    }
}

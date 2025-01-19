//
//  TableViewControllerProtocols.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 17/01/25.
//

import UIKit

enum ListState: Equatable {
    case loading
    case loaded
    case empty(message: String)
    case error(message: String)
}

protocol TableViewDelegate: AnyObject {
    func reloadData()
    func showFeedback(_ type: FeedbackType)
    func removeFeedback()
}

protocol TableViewModelProtocol: AnyObject {
    associatedtype T: Codable
    var title: String { get }
    var numberOfItems: Int { get }
    var items: [T] { get }
    var state: ListState { get }
    var emptyFeedbackMessage: String { get }
    var itensPerPage: Int { get }
    var currentPage: Int { get }
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
    func getNextPageIfNeeded(at indexPath: IndexPath)
    func showFeedbackIfNeeded()
    func getStateAfterResponse() -> ListState
    func showFeedback(_ type: FeedbackType)
    func removeFeedback()
}

extension TableViewModelProtocol {
    var itensPerPage: Int { 10 }
    
    func getStateAfterResponse() -> ListState {
        if items.isEmpty {
            return .empty(message: emptyFeedbackMessage)
        }
        return .loaded
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
            showFeedback(.message(message, systemImageName: "exclamationmark.circle", imageColor: .systemRed))
        }
    }
}

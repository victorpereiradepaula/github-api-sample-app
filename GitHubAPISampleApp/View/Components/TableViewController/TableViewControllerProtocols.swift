//
//  TableViewControllerProtocols.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 17/01/25.
//

import UIKit

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
    var isLoading: Bool { get }
    var emptyFeedbackMessage: String { get }
    var itensPerPage: Int { get }
    var currentPage: Int { get }
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
    func getNextPageIfNeeded(at indexPath: IndexPath)
    func showFeedbackIfNeeded()
    func showFeedback(_ type: FeedbackType)
    func removeFeedback()
}

extension TableViewModelProtocol {
    var itensPerPage: Int { 10 }
    
    func showFeedbackIfNeeded() {
        if isLoading, items.isEmpty {
            showFeedback(.loading)
        } else if items.isEmpty {
            showFeedback(.empty(emptyFeedbackMessage))
        } else {
            removeFeedback()
        }
    }
}

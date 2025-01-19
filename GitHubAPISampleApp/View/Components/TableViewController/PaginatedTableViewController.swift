//
//  PaginatedTableViewController.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit


/// Use as a base class when creating a paginated tableView
class PaginatedTableViewController<V: PaginatedTableViewModelProtocol>: UIViewController, UITableViewDelegate, UITableViewDataSource, PaginatedTableViewDelegate {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()
    
    private var feedbackView: FeedbackView?
    
    let viewModel: V
    
    init(viewModel: V) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.title = viewModel.title
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubViewWithAllSideConstraints(tableView)
        
        viewModel.viewDidLoad()
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.getNextPageIfNeeded(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }

    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        #if DEBUG
        fatalError("Needs override.")
        #else
        return tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath)
        #endif
    }
    
    // MARK: PaginatedTableViewDelegate
    func reloadData() {
        tableView.reloadData()
    }
    
    func showFeedback(_ type: FeedbackType) {
        let feedbackView = FeedbackView()
        feedbackView.addFeedback(to: view, type: type)
        self.feedbackView = feedbackView
    }
    
    func removeFeedback() {
        feedbackView?.removeFromSuperview()
        feedbackView = nil
    }
}


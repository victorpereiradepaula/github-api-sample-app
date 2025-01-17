//
//  TableViewController.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import UIKit

protocol TableViewDelegate: AnyObject {
    func reloadData()
}

protocol TableViewModelProtocol: AnyObject {
    associatedtype T: Codable
    var title: String { get }
    var numberOfItems: Int { get }
    var items: [T] { get }
    func didSelectItem(at indexPath: IndexPath)
}

class TableViewController<V: TableViewModelProtocol>: UITableViewController, TableViewDelegate {
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
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }

    // MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
    
    // MARK: TableViewDelegate
    func reloadData() {
        tableView.reloadData()
    }
}


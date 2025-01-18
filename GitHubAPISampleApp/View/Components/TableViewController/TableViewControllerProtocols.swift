//
//  TableViewControllerProtocols.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 17/01/25.
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
    var itensPerPage: Int { get }
    var currentPage: Int { get }
    func didSelectItem(at indexPath: IndexPath)
    func getNextPageIfNeeded(at indexPath: IndexPath)
}

extension TableViewModelProtocol {
    var itensPerPage: Int { 10 }
}

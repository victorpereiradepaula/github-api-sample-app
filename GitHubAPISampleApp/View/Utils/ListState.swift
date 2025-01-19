//
//  ListState.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 19/01/25.
//

enum ListState: Equatable {
    case loading
    case loaded
    case empty(message: String)
    case error(message: String)
}

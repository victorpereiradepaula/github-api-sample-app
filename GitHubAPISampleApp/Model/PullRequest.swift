//
//  PullRequest.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import Foundation

struct PullRequest: Codable {
    let url: URL
    let title: String
    let user: User
    let body: String
    let createdAt: String
    let state: PullRequestState?
}

enum PullRequestState: String, Codable {
    case open
    case closed
}

//
//  PullRequest.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

import Foundation

struct PullRequest: Codable {
    let htmlUrl: URL
    let title: String
    let user: User
    let body: String?
    let createdAt: String
    let mergedAt: String?
    let state: String?
    let draft: Bool
    
    var completeState: PullRequestState {
        if mergedAt != nil {
            return .merged
        } else if draft {
            return .draft
        }
        return PullRequestState(rawValue: state ?? "") ?? .unowned
    }
}

enum PullRequestState: String {
    case open
    case closed
    case merged
    case draft
    case unowned
}

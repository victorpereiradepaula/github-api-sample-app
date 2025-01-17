//
//  User.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

struct User: Codable {
    let id: Int
    let login: String
    let name: String?
    let avatarUrl: String
}

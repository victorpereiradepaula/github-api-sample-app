//
//  Repository.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 16/01/25.
//

struct Repository: Codable {
    let name: String
    let fullName: String
    let description: String
    let stargazersCount: Int
    let forksCount: Int
    let owner: User
}

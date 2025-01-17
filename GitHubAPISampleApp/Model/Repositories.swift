//
//  Repositories.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 17/01/25.
//


struct Repositories: Codable {
    let totalCount: Int
    let items: [Repository]
}
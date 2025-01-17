//
//  APIError.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 17/01/25.
//

struct APIError: Codable, Error {
    let message: String
    let documentationUrl: String
    let status: String
}

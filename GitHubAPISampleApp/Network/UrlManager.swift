//
//  UrlManager.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 19/01/25.
//

enum UrlManager {
    static let baseUrl = "https://api.github.com/"
    
    static func createUrl(_ path: String, itensPerPage: Int? = nil, currentPage: Int? = nil) -> String {
        let url = UrlManager.baseUrl + path
        if let itensPerPage = itensPerPage {
            return url + "&per_page=\(itensPerPage)"
        }
        
        if let currentPage = currentPage {
            return url + "&page=\(currentPage)"
        }

        return url
    }
}

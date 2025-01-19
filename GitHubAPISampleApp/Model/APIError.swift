//
//  APIError.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 17/01/25.
//

import Alamofire

struct APIError: Codable, Error {
    let message: String
    let documentationUrl: String
    let status: String
    
    init(_ error: AFError) {
        self.status = "Alamofire error"
        self.documentationUrl = ""
        self.message = error.errorDescription ?? error.localizedDescription
    }
    
    var localizedDescription: String {
        "\(status) - \(message)\n\(documentationUrl)"
    }
}

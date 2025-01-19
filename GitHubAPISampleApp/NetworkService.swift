//
//  NetworkService.swift
//  GitHubAPISampleApp
//
//  Created by Victor Pereira de Paula on 17/01/25.
//

import Alamofire

final class NetworkService {
    private let session: Session
    
    init(_ session: Session = Session.default) {
        self.session = session
    }
    
    func request<T: Codable>(type: T.Type, stringUrl: String, completion: @escaping (Result<T, APIError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        session.request(stringUrl).responseDecodable(of: T.self, decoder: jsonDecoder) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                if let data = response.data, let apiError = try? jsonDecoder.decode(APIError.self, from: data) {
                    completion(.failure(apiError))
                } else {
                    completion(.failure(APIError(error)))
                }
            }
        }
    }
}

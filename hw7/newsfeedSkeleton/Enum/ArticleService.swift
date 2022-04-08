//
//  ArticleService.swift
//  newsfeedSkeleton
//
//  Created by saerom on 4/7/22.
//

import Foundation
import Combine

protocol ArticleService {
    func request(from endpoint: ArticleAPI) -> AnyPublisher<Response, APIError>
}

struct ArticleServiceImpl: ArticleService {
    
    func request(from endpoint: ArticleAPI) -> AnyPublisher<Response, APIError> {
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return URLSession.shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError{ _ in .unknown}
            .flatMap{ data, response -> AnyPublisher<Response, APIError> in
                      
                guard let response = response  as? HTTPURLResponse else {
                        return Fail(error: .unknown)
                    .eraseToAnyPublisher()
            }
        
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                    .decode(type: Response.self, decoder: jsonDecoder)
                    .mapError{ _ in .decodingError}
                    .eraseToAnyPublisher()
            
            } else {
                return Fail(error: .errorCode(response.statusCode))
                    .eraseToAnyPublisher()
            }
            }.eraseToAnyPublisher()
    }
}

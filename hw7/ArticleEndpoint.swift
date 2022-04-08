//
//  ArticleEndpoint.swift
//  newsfeedSkeleton
//
//  Created by saerom on 4/7/22.
//

import Foundation

protocol APIBuilder {
    
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}

enum ArticleAPI {
    case getNews
}

extension ArticleAPI: APIBuilder {
    
    var baseUrl: URL {
        switch self {
        case .getNews:
            return URL(string: "https://api.lil.software")!
        }
    }
    
    var path: String {
        switch self {
        case .getNews:
            return "/news"
        }
    }
    
    var urlRequest: URLRequest {
        switch self {
        case .getNews:
            return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
        }
    }
    
}

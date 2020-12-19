//
//  APIRouters.swift
//  App
//
//  Created by Sharetrip-iOS on 19/12/2020.
//

import Foundation

import Alamofire

enum APIRouters: APIEndpoint {
    case popularMovies

    var path: String {
        switch self {
            case .popularMovies:
                return "discover/movie"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .popularMovies:
            return .get
        }
    }

    var baseUrl: String { return "https://sharetrip-96054.firebaseio.com/" }

    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseUrl + path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }

    func asURL() throws -> URL {
        return URL(string: baseUrl + path)!
    }
}

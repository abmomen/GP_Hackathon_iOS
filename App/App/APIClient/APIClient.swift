//
//  APIClient.swift
//  App
//
//  Created by Sharetrip-iOS on 19/12/2020.
//

import Foundation
import Alamofire

class APIClient {
    @discardableResult
    static func performRequest<T:Decodable>(route: APIEndpoint, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (AFResult<T>)->Void) -> DataRequest {

        return AF.request(route).responseDecodable(decoder: decoder) { (response: DataResponse<T, AFError>) in
            completion(response.result)
        }
    }
}

extension APIClient {
    func getPopularMovies(completion: @escaping (AFResult<PopularMovies>) -> Void) {
        APIClient.performRequest(route: APIRouters.popularMovies, completion: completion)
    }
}

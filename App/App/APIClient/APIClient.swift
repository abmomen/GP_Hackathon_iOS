
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
    func getPopularMovies(params: Parameters, completion: @escaping (AFResult<PopularMovies>) -> Void) {
        APIClient.performRequest(route: APIRouters.popularMovies(params: params), completion: completion)
    }
    
    func getPopularTVSeries(params: Parameters, completion: @escaping (AFResult<PopularTVSeries>) -> Void) {
        APIClient.performRequest(route: APIRouters.popularTVSeries(params: params), completion: completion)
    }
}

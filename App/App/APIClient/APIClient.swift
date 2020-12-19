
import Foundation
import Alamofire

class APIClient {
    private static func logResponse<T: Decodable>(_ response: DataResponse<T, AFError>) {
        #if DEBUG
        print("\nRequest Details:")
        if let urlRequest = response.request {

            print("URL: \(String(describing: urlRequest.url))")
            if let method = urlRequest.method {
                print("Request Method: \(method.rawValue)")
            }
            print("Header:\n \(urlRequest.headers)")
            
            if let bodyData = urlRequest.httpBody?.prettyPrintedJSONString {
                print("Body Data:\n \(bodyData)")
            }
        }
        print("\nResponse Details:")
        print("Status Code: \(String(describing: response.response?.statusCode)) \nResult: \(response.result)")
        if let responseData = response.data?.prettyPrintedJSONString {
            print("Response Data:\n \(responseData)")
        }
        #endif
    }
    
    @discardableResult
    static func performRequest<T:Decodable>(route: APIEndpoint, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (AFResult<T>)->Void) -> DataRequest {

        return AF.request(route).responseDecodable(decoder: decoder) { (response: DataResponse<T, AFError>) in
            logResponse(response)
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

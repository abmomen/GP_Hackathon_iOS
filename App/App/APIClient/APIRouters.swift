
import Foundation

import Alamofire

enum APIRouters: APIEndpoint {
    case popularMovies(params: Parameters)
    case popularTVSeries(params: Parameters)
    
    var baseUrl: String { return "https://api.themoviedb.org/3/" }
    
    var path: String {
        switch self {
        case .popularMovies:
            return "discover/movie"
        case .popularTVSeries:
            return "discover/tv"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .popularMovies, .popularTVSeries:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .popularMovies(let params):
            return params
        case .popularTVSeries(let params):
            return params
        }
    }
}

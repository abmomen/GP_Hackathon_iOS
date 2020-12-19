
import Foundation
import Alamofire

protocol APIEndpoint: URLRequestConvertible, URLConvertible {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var bodyData: Data? { get }
    var contentType: ContentType? { get }

    func asURLRequest() throws -> URLRequest
    func asURL() throws -> URL
}

extension APIEndpoint {
    /// Default content type, you can always provide your own
    var contentType: ContentType? { .json }

    /// Default implementaion
    var parameters: Parameters? { nil }

    /// Default implementaion
    var bodyData: Data? { nil }
}


extension APIEndpoint  {
    // Encode complex key/value objects in URLQueryItem pairs
    private func queryItems(_ key: String, _ value: Any?) -> [URLQueryItem] {
        var result = [] as [URLQueryItem]

        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                result += queryItems("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            //let arrKey = key + "[]"
            let arrKey = key
            for value in array {
                result += queryItems(arrKey, value)
            }
        } else if let value = value {
            result.append(URLQueryItem(name: key, value: "\(value)"))
        } else {
            result.append(URLQueryItem(name: key, value: nil))
        }

        return result
    }

    // Encodes complex [String: AnyObject] params into array of URLQueryItem
    private func paramsToQueryItems(_ params: [String: Any]?) -> [URLQueryItem]? {
        guard let params = params else { return nil }

        var result = [] as [URLQueryItem]

        for (key, value) in params {
            result += queryItems(key, value)
        }
        //return result.sorted(by: { $0.name < $1.name })
        return result
    }


    /// Default  implementation, you can always provide your own
    func asURLRequest() throws -> URLRequest {

        /*let baseURL = try Constants.ProductionServer.baseURL.asURL()
         let url = baseURL.appendingPathComponent(path)*/
        var urlComponents = URLComponents(string: AppURL.App.baseUrl + path)!

        // Parameters
        var httpBody: Data?
        if let parameters = parameters {
            do {
                if method == .get {

                    if let items = paramsToQueryItems(parameters) {
                        urlComponents.queryItems = items
                    }

                } else {
                    //POST
                    httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                }
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        } else if let bodyData = bodyData {
            //POST only
            httpBody = bodyData
        }

        var urlRequest = URLRequest(url: urlComponents.url!)

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        //Encoding

        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        if let contentType = contentType?.rawValue {
            urlRequest.setValue(contentType, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        }

        //httpbody
        urlRequest.httpBody = httpBody

        return urlRequest
    }

    /// Default  implementation, you can always provide your own
    func asURL() throws -> URL {
        let url = URL(string: AppURL.App.baseUrl + path)!
        return url
    }
}

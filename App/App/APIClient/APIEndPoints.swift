
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

//Default implementation
extension APIEndpoint {
    var contentType: ContentType? { .json }
    var bodyData: Data? { nil }
}


extension APIEndpoint  {
    private func queryItems(_ key: String, _ value: Any?) -> [URLQueryItem] {
        var result = [] as [URLQueryItem]

        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                result += queryItems("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
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

    private func paramsToQueryItems(_ params: [String: Any]?) -> [URLQueryItem]? {
        guard let params = params else { return nil }

        var result = [] as [URLQueryItem]

        for (key, value) in params {
            result += queryItems(key, value)
        }
        return result
    }


    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents(string: AppURL.App.baseUrl + path)!

        var httpBody: Data?
        if let parameters = parameters {
            do {
                if method == .get {
                    if let items = paramsToQueryItems(parameters) {
                        urlComponents.queryItems = items
                    }

                } else {
                    httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                }
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        } else if let bodyData = bodyData {
            httpBody = bodyData
        }

        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        if let contentType = contentType?.rawValue {
            urlRequest.setValue(contentType, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        }

        urlRequest.httpBody = httpBody
        return urlRequest
    }

    func asURL() throws -> URL {
        let url = URL(string: AppURL.App.baseUrl + path)!
        return url
    }
}

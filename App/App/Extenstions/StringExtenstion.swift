
import Foundation

enum ContentType: String {
    case json = "application/json"
    case multipartFormData = "multipart/form-data"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case accessToken = "accesstoken"
    case userAgent = "User-Agent"
    case stAccess = "st-access"
    case travelAdviceAPIAccessToken = "X-Access-Token"
}

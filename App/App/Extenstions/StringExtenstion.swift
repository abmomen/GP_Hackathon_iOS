
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

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString
    }
}

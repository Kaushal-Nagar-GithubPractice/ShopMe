//
//  NetworkManager.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 28/06/24.
//

import Foundation

enum HeaderValue{
    case headerForLogin
    case headerWithToken
    case headerWithoutAuthToken
    case headerMultiPart
    
    var value: [HTTPHeader]{
        switch self{
        case .headerForLogin:
            let header: [HTTPHeader] = [HTTPHeader(field: "device", value: "ios"),
                                        HTTPHeader(field: "build-version", value: ""),
                                        HTTPHeader(field: headerContentType, value: contentTypeUrlJSON),
                                        HTTPHeader(field: "push-token", value: "")]
            return header
        case .headerWithToken:
            let header: [HTTPHeader] = [HTTPHeader(field: "device", value: "ios"),
                                        HTTPHeader(field: "build-version", value: ""),
                                        HTTPHeader(field: headerContentType, value: contentTypeUrlJSON),
                                        HTTPHeader(field: "Authorization", value: "Bearer " + (UserDefaults.standard.string(forKey: "token") ?? ""))]

            return header
        case .headerWithoutAuthToken:
            let header: [HTTPHeader] = [HTTPHeader(field: "device", value: "ios"),
                                        HTTPHeader(field: "build-version", value: ""),
                                        HTTPHeader(field: headerContentType, value: contentTypeUrlJSON)]
            return header
        case .headerMultiPart:
            let header: [HTTPHeader] = [HTTPHeader(field: "device", value: "ios"),
                                        HTTPHeader(field: "build-version", value: ""),
                                        HTTPHeader(field: headerContentType,
                                                   value: "multipart/form-data; boundary="),
                                        HTTPHeader(field: "Authorization", value: "Bearer " + (UserDefaults.standard.string(forKey: "token") ?? ""))]
            return header
        }
    }
}
struct HTTPHeader {
    let field: String
    let value: String
}
enum HTTPMethods: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}

class APIRequest {
    let isLoader: Bool?
    let method: HTTPMethods
    let path: String
    let headers: [HTTPHeader]?
    let body: [String:Any]?
    init(isLoader: Bool?, method: HTTPMethods, path: String, headers: [HTTPHeader]?, body: [String : Any]?) {
        self.isLoader = isLoader
        self.method = method
        self.path = path
        self.headers = headers
        self.body = body
    }
}
struct APIResponse<Body> {
    let statusCode: Int
    let body: Body
}
extension APIResponse where Body == Data?{
    func decode<BodyType: Decodable>(to type: BodyType.Type) throws -> APIResponse<BodyType>{
        guard let data = body else {
            throw APIError.decodingFailure
        }
        let decodedJSON = try JSONDecoder().decode(BodyType.self, from: data)
        return APIResponse<BodyType>(statusCode: self.statusCode, body: decodedJSON)
    }
}
enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailure
}
enum APIResult<Body> {
    case success(APIResponse<Body>)
    case failure(APIError)
}
struct APIClient {
    typealias APIClientCompletion = (APIResult<Data?>) -> Void
    private let session = URLSession.shared
    func perform(_ request: APIRequest, _ complation: @escaping (Data?, NSError?) -> Void) {
        var urlRequest = URLRequest(url: URL(string: request.path)!)
        urlRequest.httpMethod = request.method.rawValue
        if request.body != nil {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: request.body! as Any, options: []) else {
                return
            }
            urlRequest.httpBody = httpBody
        }
        request.headers?.forEach{
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.field)
        }
        let task = session.dataTask(with: urlRequest) { (data, _, error ) in
            if let data = data {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    if let code = json?["code"] as? Int {
                        if code == 401 {
                        }
                    }
                    print("==>...NW...>",json)
                }catch{
                    print("catch")
                }
                print(data)
                complation(data,nil)
            }else {
                complation(nil,error as NSError?)
            }
        }
        task.resume()
    }
}

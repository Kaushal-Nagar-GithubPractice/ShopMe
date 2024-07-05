//
//  MultiPartNetworkService.swift
//  LeadExpert
//
//  Created by WCGmac-001 on 09/01/23.
//

import Foundation
import UIKit
//import Alamofire

struct MultiPartNetworkService {
    
   func uploadRequest(image: UIImage?,
                       param: [String: Any]?,
                       url: String,
                       imageName: String,
                       _ completion: @escaping (UpdateData_Struct?, NSError?) -> Void) {

//        ActivityIndicator.sharedInstance.showHUD(show: true)
        let boundary = generateBoundary()
        var request = URLRequest(url: URL(string: url)!)
        if image != nil {
            guard let mediaImage = MediaModel(withImage: image!, forKey: imageName) else { return }
            let dataBody = createDataBody(withParameters: param, media: [mediaImage], boundary: boundary)
            request.httpBody = dataBody
        } else {
            let dataBody = createDataBody(withParameters: param, media: nil, boundary: boundary)
            request.httpBody = dataBody
        }
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Content-Type": "multipart/form-data; boundary=\(boundary)",
            "Authorization": "Bearer " + (UserDefaults.standard.string(forKey: "token") ?? "")
        ]
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if response is HTTPURLResponse {
//                if httpResponse.statusCode == 401 {
//                    self.requestForNewAccessToken(image: image, param: param, url: url, imageName: imageName, oldCompletion: completion)
//                }
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        var response = try JSONDecoder().decode(UpdateData_Struct.self, from: data)
                        
                        print("\nUpdate Profile API Response\n",response)
                        completion(response, nil)
//                        ActivityIndicator.sharedInstance.showHUD(show: false)
//                        print(json)
                    } catch {
                        completion(nil, error as NSError)
//                        ActivityIndicator.sharedInstance.showHUD(show: false)
//                        print(error)
                    }
                }
            }
           
        }.resume()
    }
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    func createDataBody(withParameters params: [String: Any]?, media: [MediaModel]?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value)\(lineBreak)")
            }
        }
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.fileName)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

struct MediaModel {
    let key: String
    let fileName: String
    let data: Data
    let mimeType: String
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpg"
        self.fileName = "\(arc4random()).jpeg"
        guard let data = image.jpegData(compressionQuality: 0.9) else { return nil }
        self.data = data
    }
}

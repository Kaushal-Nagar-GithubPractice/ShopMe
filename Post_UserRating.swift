//
//  Post_UserRating.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 05/07/24.
//
//
//import Foundation
//struct Post_UserRating : Codable {
//    let type : String?
//    let success : Bool?
//    let status : Int?
//    let message : String?
//    let data : Post_UserRating_Data?
//
//    enum CodingKeys: String, CodingKey {
//
//        case type = "type"
//        case success = "success"
//        case status = "status"
//        case message = "message"
//        case data = "data"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        success = try values.decodeIfPresent(Bool.self, forKey: .success)
//        status = try values.decodeIfPresent(Int.self, forKey: .status)
//        message = try values.decodeIfPresent(String.self, forKey: .message)
//        data = try values.decodeIfPresent(Post_UserRating_Data.self, forKey: .data)
//    }
//
//}
//struct Post_UserRating_Data : Codable {
//
//    enum CodingKeys: String, CodingKey {
//        typealias RawValue = <#type#>
//        
//
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//    }
//
//}

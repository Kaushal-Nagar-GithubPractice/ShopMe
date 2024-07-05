//
//  Post_WishlistModel.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 05/07/24.
//

import Foundation
struct Post_WhislistModel : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : Post_Whislist?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case success = "success"
        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(Post_Whislist.self, forKey: .data)
    }

}

struct Post_Whislist : Codable {
    let userId : String?
    let products : [String]?
    let updatedAt : String?

    enum CodingKeys: String, CodingKey {

        case userId = "userId"
        case products = "products"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        products = try values.decodeIfPresent([String].self, forKey: .products)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

}

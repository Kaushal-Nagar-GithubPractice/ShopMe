//
//  WishlistModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 05/07/24.
//

import Foundation

struct WishListmodel : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : wishlist_Data?

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
        data = try values.decodeIfPresent(wishlist_Data.self, forKey: .data)
    }

}
struct wishlist_Data : Codable {
    let products : [wishlist_Products]?
    let userId : String?

    enum CodingKeys: String, CodingKey {

        case products = "products"
        case userId = "userId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decodeIfPresent([wishlist_Products].self, forKey: .products)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }

}
//Swift.DecodingError.dataCorrupted(Swift.DecodingError.Context(codingPath: [CodingKeys(stringValue: "data", intValue: nil), CodingKeys(stringValue: "products", intValue: nil), _JSONKey(stringValue: "Index 0", intValue: 0), CodingKeys(stringValue: "ratings", intValue: nil)], debugDescription: "Parsed JSON number <3.5> does not fit in Int.", underlyingError: nil))
struct wishlist_Products : Codable {
    let productId : String?
    let productName : String?
    let price : Int?
    let images : [String]?
    let sizes : [String]?
    let color : [String]?
    let description : String?
    let ratings : Double?
    let reviews : Int?

    enum CodingKeys: String, CodingKey {

        case productId = "productId"
        case productName = "productName"
        case price = "price"
        case images = "images"
        case sizes = "sizes"
        case color = "color"
        case description = "description"
        case ratings = "ratings"
        case reviews = "reviews"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productId = try values.decodeIfPresent(String.self, forKey: .productId)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        sizes = try values.decodeIfPresent([String].self, forKey: .sizes)
        color = try values.decodeIfPresent([String].self, forKey: .color)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        ratings = try values.decodeIfPresent(Double.self, forKey: .ratings)
        reviews = try values.decodeIfPresent(Int.self, forKey: .reviews)
    }

}

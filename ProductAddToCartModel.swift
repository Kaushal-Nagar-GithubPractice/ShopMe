//
//  ProductAddToCartModel.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 02/07/24.
//

import Foundation
struct ProductAddToCart : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : CartDetails?

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
        data = try values.decodeIfPresent(CartDetails.self, forKey: .data)
    }

}

struct CartDetails : Codable {
    let _id : String?
    let userId : String?
    let products : [ProductsInCartDetails]?
    let totalAmount : Int?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case userId = "userId"
        case products = "products"
        case totalAmount = "totalAmount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        products = try values.decodeIfPresent([ProductsInCartDetails].self, forKey: .products)
        totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount)
    }

}

struct ProductsInCartDetails : Codable {
    let productId : String?
    let quantity : Int?
    let size : String?
    let color : String?
    let price : Int?
    let _id : String?

    enum CodingKeys: String, CodingKey {

        case productId = "productId"
        case quantity = "quantity"
        case size = "size"
        case color = "color"
        case price = "price"
        case _id = "_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productId = try values.decodeIfPresent(String.self, forKey: .productId)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        size = try values.decodeIfPresent(String.self, forKey: .size)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
    }

}


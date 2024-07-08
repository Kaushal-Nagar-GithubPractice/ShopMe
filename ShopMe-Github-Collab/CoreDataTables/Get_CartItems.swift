//
//  Get_CartDetails.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 04/07/24.
//

import Foundation
struct Get_CartItems : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : Get_CartDetails?

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
        data = try values.decodeIfPresent(Get_CartDetails.self, forKey: .data)
    }

}

struct Get_CartDetails : Codable {
    let _id : String?
    let products : [Get_CartProducts]?
    let totalAmount : Int?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case products = "products"
        case totalAmount = "totalAmount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        products = try values.decodeIfPresent([Get_CartProducts].self, forKey: .products)
        totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount)
    }

}

struct Get_CartProducts : Codable {
    let _id : String?
    let productId : String?
    let quantity : Int?
    let price : Int?
    let color : String?
    let size : String?
    let productName : String?
    let images : [String]?
    let totalProductPrice : Int?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case productId = "productId"
        case quantity = "quantity"
        case price = "price"
        case color = "color"
        case size = "size"
        case productName = "productName"
        case images = "Images"
        case totalProductPrice = "totalProductPrice"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        productId = try values.decodeIfPresent(String.self, forKey: .productId)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        size = try values.decodeIfPresent(String.self, forKey: .size)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        totalProductPrice = try values.decodeIfPresent(Int.self, forKey: .totalProductPrice)
    }

}

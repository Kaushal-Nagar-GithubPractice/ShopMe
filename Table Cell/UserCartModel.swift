//
//  UserCartModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 28/06/24.
//

//import Foundation

import Foundation
struct UserCartModel : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : cartData?

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
        data = try values.decodeIfPresent(cartData.self, forKey: .data)
    }

}
struct cartData : Codable {
    let _id : String?
    let products : [cart_Products]?
    var totalAmount : Int?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case products = "products"
        case totalAmount = "totalAmount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        products = try values.decodeIfPresent([cart_Products].self, forKey: .products)
        totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount)
    }

}
struct cart_Products : Codable {
    let _id : String?
    let productId : String?
    var quantity : Int?
    let price : Int?
    let color : String?
    let size : String?
    let productName : String?
    let images : [String]?
    var totalProductPrice : Int?

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

//import Foundation
//struct UserCartModel : Codable {
//    let type : String?
//    let success:Bool? //
//    let status : Int?
//    let message : String?
//    let data : cartData?
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
//        data = try values.decodeIfPresent(cartData.self, forKey: .data)
//    }
//
//}
//struct cartData : Codable {
//    let _id : String?
//    let products : [Products]?
//    var totalAmount : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case _id = "_id"
//        case products = "products"
//        case totalAmount = "totalAmount"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        _id = try values.decodeIfPresent(String.self, forKey: ._id)
//        products = try values.decodeIfPresent([Products].self, forKey: .products)
//        totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount)
//    }
//
//}
//
//struct Products : Codable {
//    let productId : String?
//    var quantity : Int?
//    let price : Int?
//    let productName : String?
//    let images : [String]?
//    var totalProductPrice : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case productId = "productId"
//        case quantity = "quantity"
//        case price = "price"
//        case productName = "productName"
//        case images = "Images"
//        case totalProductPrice = "totalProductPrice"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        productId = try values.decodeIfPresent(String.self, forKey: .productId)
//        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
//        price = try values.decodeIfPresent(Int.self, forKey: .price)
//        productName = try values.decodeIfPresent(String.self, forKey: .productName)
//        images = try values.decodeIfPresent([String].self, forKey: .images)
//        totalProductPrice = try values.decodeIfPresent(Int.self, forKey: .totalProductPrice)
//    }
//
//}

//
//  OrderListModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 03/07/24.
//

import Foundation

struct OrderListing_Main : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : OrderListing_Data?

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
        data = try values.decodeIfPresent(OrderListing_Data.self, forKey: .data)
    }

}

struct OrderListing_Data : Codable {
    let orders : [OrderListing_Orders]?
    let page : Int?
    let items : Int?
    let total_count : Int?
    let min_price : Int?
    let max_price : Int?

    enum CodingKeys: String, CodingKey {

        case orders = "orders"
        case page = "page"
        case items = "items"
        case total_count = "total_count"
        case min_price = "min_price"
        case max_price = "max_price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orders = try values.decodeIfPresent([OrderListing_Orders].self, forKey: .orders)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        items = try values.decodeIfPresent(Int.self, forKey: .items)
        total_count = try values.decodeIfPresent(Int.self, forKey: .total_count)
        min_price = try values.decodeIfPresent(Int.self, forKey: .min_price)
        max_price = try values.decodeIfPresent(Int.self, forKey: .max_price)
    }

}

struct OrderListing_Orders : Codable {
    let _id : String?
    let userId : String?
    let products : [OrderListing_Products]?
    let totalAmount : Int?
    let discount : Int?
    let originalPrice : Int?
    let billingAddress : OrderListing_BillingAddress?
    let paymentMethod : String?
    let orderStatus : String?
    let createdAt : String?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case userId = "userId"
        case products = "products"
        case totalAmount = "totalAmount"
        case discount = "discount"
        case originalPrice = "originalPrice"
        case billingAddress = "billingAddress"
        case paymentMethod = "paymentMethod"
        case orderStatus = "orderStatus"
        case createdAt = "createdAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        products = try values.decodeIfPresent([OrderListing_Products].self, forKey: .products)
        totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount)
        discount = try values.decodeIfPresent(Int.self, forKey: .discount)
        originalPrice = try values.decodeIfPresent(Int.self, forKey: .originalPrice)
        billingAddress = try values.decodeIfPresent(OrderListing_BillingAddress.self, forKey: .billingAddress)
        paymentMethod = try values.decodeIfPresent(String.self, forKey: .paymentMethod)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
    }

}

struct OrderListing_Products : Codable {
    let productName : String?
    let size : String?
    let color : String?
    let quantity : Int?
    let productId : String?
    let _id : String?
    let price : Int?
    let totalProductPrice : Int?
    let image : String?

    enum CodingKeys: String, CodingKey {

        case productName = "productName"
        case size = "size"
        case color = "color"
        case quantity = "quantity"
        case productId = "productId"
        case _id = "_id"
        case price = "price"
        case totalProductPrice = "totalProductPrice"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        size = try values.decodeIfPresent(String.self, forKey: .size)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        productId = try values.decodeIfPresent(String.self, forKey: .productId)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        totalProductPrice = try values.decodeIfPresent(Int.self, forKey: .totalProductPrice)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }

}

struct OrderListing_BillingAddress : Codable {
    let firstName : String?
    let email : String?
    let lastName : String?
    let mobileNo : Int?
    let addressLine1 : String?
    let addressLine2 : String?
    let country : String?
    let city : String?
    let state : String?
    let zipcode : Int?

    enum CodingKeys: String, CodingKey {

        case firstName = "firstName"
        case email = "email"
        case lastName = "lastName"
        case mobileNo = "mobileNo"
        case addressLine1 = "addressLine1"
        case addressLine2 = "addressLine2"
        case country = "country"
        case city = "city"
        case state = "state"
        case zipcode = "zipcode"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        mobileNo = try values.decodeIfPresent(Int.self, forKey: .mobileNo)
        addressLine1 = try values.decodeIfPresent(String.self, forKey: .addressLine1)
        addressLine2 = try values.decodeIfPresent(String.self, forKey: .addressLine2)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        zipcode = try values.decodeIfPresent(Int.self, forKey: .zipcode)
    }

}

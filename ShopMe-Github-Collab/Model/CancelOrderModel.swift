//
//  CancelOrderModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 10/07/24.
//

import Foundation

struct Cancel_Order_Main : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : Cancel_Order_Data?

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
        data = try values.decodeIfPresent(Cancel_Order_Data.self, forKey: .data)
    }

}

struct Cancel_Order_Data : Codable {
    let billingAddress : Cancel_Order_BillingAddress?
    let _id : String?
    let userId : String?
    let products : [Cancel_Order_Products]?
    let totalAmount : Int?
    let paymentMethod : String?
    let orderStatus : String?
    let createdAt : String?
    let updatedAt : String?

    enum CodingKeys: String, CodingKey {

        case billingAddress = "billingAddress"
        case _id = "_id"
        case userId = "userId"
        case products = "products"
        case totalAmount = "totalAmount"
        case paymentMethod = "paymentMethod"
        case orderStatus = "orderStatus"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        billingAddress = try values.decodeIfPresent(Cancel_Order_BillingAddress.self, forKey: .billingAddress)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        products = try values.decodeIfPresent([Cancel_Order_Products].self, forKey: .products)
        totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount)
        paymentMethod = try values.decodeIfPresent(String.self, forKey: .paymentMethod)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

}

struct Cancel_Order_BillingAddress : Codable {
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



struct Cancel_Order_Products : Codable {
    let productId : String?
    let image : String?
    let productName : String?
    let size : String?
    let color : String?
    let quantity : Int?
    let price : Int?
    let _id : String?

    enum CodingKeys: String, CodingKey {

        case productId = "productId"
        case image = "image"
        case productName = "productName"
        case size = "size"
        case color = "color"
        case quantity = "quantity"
        case price = "price"
        case _id = "_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productId = try values.decodeIfPresent(String.self, forKey: .productId)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        size = try values.decodeIfPresent(String.self, forKey: .size)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
    }

}

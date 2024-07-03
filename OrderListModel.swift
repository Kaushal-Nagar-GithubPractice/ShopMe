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

    enum CodingKeys: String, CodingKey {

        case orders = "orders"
        case page = "page"
        case items = "items"
        case total_count = "total_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orders = try values.decodeIfPresent([OrderListing_Orders].self, forKey: .orders)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        items = try values.decodeIfPresent(Int.self, forKey: .items)
        total_count = try values.decodeIfPresent(Int.self, forKey: .total_count)
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


struct OrderListing_Information : Codable {
    let description : String?
    let infoPoints : [String]?

    enum CodingKeys: String, CodingKey {

        case description = "description"
        case infoPoints = "infoPoints"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        infoPoints = try values.decodeIfPresent([String].self, forKey: .infoPoints)
    }

}


struct OrderListing_Orders : Codable {
    let _id : String?
    let userId : String?
    let products : [OrderListing_Products]?
    let billingAddress : OrderListing_BillingAddress?
    let totalAmount : Int?
    let paymentMethod : String?
    let createdAt : String?
    let orderStatus : String?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case userId = "userId"
        case products = "products"
        case billingAddress = "billingAddress"
        case totalAmount = "totalAmount"
        case paymentMethod = "paymentMethod"
        case createdAt = "createdAt"
        case orderStatus = "orderStatus"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        products = try values.decodeIfPresent([OrderListing_Products].self, forKey: .products)
        billingAddress = try values.decodeIfPresent(OrderListing_BillingAddress.self, forKey: .billingAddress)
        totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount)
        paymentMethod = try values.decodeIfPresent(String.self, forKey: .paymentMethod)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
    }

}

struct OrderListing_Products : Codable {
    let categoryId : String?
    let productName : String?
    let images : [String]?
    let price : Int?
    let sellingPrice : Int?
    let colors : [String]?
    let size : [String]?
    let mainDescription : String?
    let subDescription : String?
    let tags : [String]?
    let information : OrderListing_Information?
    let isFeatured : Bool?
    let isActive : Bool?

    enum CodingKeys: String, CodingKey {

        case categoryId = "categoryId"
        case productName = "productName"
        case images = "images"
        case price = "price"
        case sellingPrice = "sellingPrice"
        case colors = "colors"
        case size = "size"
        case mainDescription = "mainDescription"
        case subDescription = "subDescription"
        case tags = "tags"
        case information = "information"
        case isFeatured = "isFeatured"
        case isActive = "isActive"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        sellingPrice = try values.decodeIfPresent(Int.self, forKey: .sellingPrice)
        colors = try values.decodeIfPresent([String].self, forKey: .colors)
        size = try values.decodeIfPresent([String].self, forKey: .size)
        mainDescription = try values.decodeIfPresent(String.self, forKey: .mainDescription)
        subDescription = try values.decodeIfPresent(String.self, forKey: .subDescription)
        tags = try values.decodeIfPresent([String].self, forKey: .tags)
        information = try values.decodeIfPresent(OrderListing_Information.self, forKey: .information)
        isFeatured = try values.decodeIfPresent(Bool.self, forKey: .isFeatured)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
    }

}

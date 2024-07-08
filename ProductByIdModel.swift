//
//  ProductByIdModel.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 02/07/24.
//


import Foundation
struct ProductById : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : SingleProduct?

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
        data = try values.decodeIfPresent(SingleProduct.self, forKey: .data)
    }

}

struct SingleProduct : Codable {
    let information : Information?
    let _id : String?
    let categoryId : String?
    let productName : String?
    let images : [String]?
    let price : Int?
    let sellingPrice : Int?
    let colors : [String]?
    let size : [String]?
    let tags : [String]?
    let isFeatured : Bool?
    let isActive : Bool?
    let mainDescription : String?
    let subDescription : String?

    enum CodingKeys: String, CodingKey {

        case information = "information"
        case _id = "_id"
        case categoryId = "categoryId"
        case productName = "productName"
        case images = "images"
        case price = "price"
        case sellingPrice = "sellingPrice"
        case colors = "colors"
        case size = "size"
        case tags = "tags"
        case isFeatured = "isFeatured"
        case isActive = "isActive"
        case mainDescription = "mainDescription"
        case subDescription = "subDescription"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        information = try values.decodeIfPresent(Information.self, forKey: .information)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        sellingPrice = try values.decodeIfPresent(Int.self, forKey: .sellingPrice)
        colors = try values.decodeIfPresent([String].self, forKey: .colors)
        size = try values.decodeIfPresent([String].self, forKey: .size)
        tags = try values.decodeIfPresent([String].self, forKey: .tags)
        isFeatured = try values.decodeIfPresent(Bool.self, forKey: .isFeatured)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        mainDescription = try values.decodeIfPresent(String.self, forKey: .mainDescription)
        subDescription = try values.decodeIfPresent(String.self, forKey: .subDescription)
    }

}


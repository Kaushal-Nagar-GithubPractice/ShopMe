//
//  Product.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 01/07/24.
//

import Foundation

import Foundation
struct Product : Codable {
    let type : String?
    let status : Int?
    let message : String?
    let data : Product_Data?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(Product_Data.self, forKey: .data)
    }

}

struct Product_Data : Codable {
    let products : [Products]?
    let page : Int?
    let items : Int?
    let total_count : Int?

    enum CodingKeys: String, CodingKey {

        case products = "products"
        case page = "page"
        case items = "items"
        case total_count = "total_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decodeIfPresent([Products].self, forKey: .products)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        items = try values.decodeIfPresent(Int.self, forKey: .items)
        total_count = try values.decodeIfPresent(Int.self, forKey: .total_count)
    }

}

struct Products : Codable {
    let _id : String?
    let productName : String?
    let images : [String]?
    let price : Int?
    let sellingPrice : Int?
    let colors : [String]?
    let size : [String]?
    let tags : [String]?
    let information : Information?
    let isFeatured : Bool?
    let isActive : Bool?
    let mainDescription : String?
    let subDescription : String?
    let category : Category?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case productName = "productName"
        case images = "images"
        case price = "price"
        case sellingPrice = "sellingPrice"
        case colors = "colors"
        case size = "size"
        case tags = "tags"
        case information = "information"
        case isFeatured = "isFeatured"
        case isActive = "isActive"
        case mainDescription = "mainDescription"
        case subDescription = "subDescription"
        case category = "category"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        sellingPrice = try values.decodeIfPresent(Int.self, forKey: .sellingPrice)
        colors = try values.decodeIfPresent([String].self, forKey: .colors)
        size = try values.decodeIfPresent([String].self, forKey: .size)
        tags = try values.decodeIfPresent([String].self, forKey: .tags)
        information = try values.decodeIfPresent(Information.self, forKey: .information)
        isFeatured = try values.decodeIfPresent(Bool.self, forKey: .isFeatured)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        mainDescription = try values.decodeIfPresent(String.self, forKey: .mainDescription)
        subDescription = try values.decodeIfPresent(String.self, forKey: .subDescription)
        category = try values.decodeIfPresent(Category.self, forKey: .category)
    }

}

struct Information : Codable {
    let infoPoints : [String]?

    enum CodingKeys: String, CodingKey {

        case infoPoints = "infoPoints"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        infoPoints = try values.decodeIfPresent([String].self, forKey: .infoPoints)
    }

}


struct Category : Codable {
    let categoryName : String?
    let bannerImage : String?
    let image : String?
    let banner : Bool?
    let isActive : Bool?
    let units : [String]?

    enum CodingKeys: String, CodingKey {

        case categoryName = "categoryName"
        case bannerImage = "bannerImage"
        case image = "image"
        case banner = "banner"
        case isActive = "isActive"
        case units = "units"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        bannerImage = try values.decodeIfPresent(String.self, forKey: .bannerImage)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        banner = try values.decodeIfPresent(Bool.self, forKey: .banner)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        units = try values.decodeIfPresent([String].self, forKey: .units)
    }

}


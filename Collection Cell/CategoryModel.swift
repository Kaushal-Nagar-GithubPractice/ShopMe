//
//  Category.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 01/07/24.
//


import Foundation
struct CategoryModel : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : Category_List?

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
        data = try values.decodeIfPresent(Category_List.self, forKey: .data)
    }

}
struct Category_List : Codable {
    let categories : [Categories_Data]?
    let page : Int?
    let items : Int?
    let total_count : Int?

    enum CodingKeys: String, CodingKey {

        case categories = "categories"
        case page = "page"
        case items = "items"
        case total_count = "total_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([Categories_Data].self, forKey: .categories)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        items = try values.decodeIfPresent(Int.self, forKey: .items)
        total_count = try values.decodeIfPresent(Int.self, forKey: .total_count)
    }

}

struct Categories_Data : Codable {
    let _id : String?
    let categoryName : String?
    let bannerImage : String?
    let image : String?
    let banner : Bool?
    let description : String?
    let productCount : Int?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case categoryName = "categoryName"
        case bannerImage = "bannerImage"
        case image = "image"
        case banner = "banner"
        case description = "description"
        case productCount = "productCount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        bannerImage = try values.decodeIfPresent(String.self, forKey: .bannerImage)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        banner = try values.decodeIfPresent(Bool.self, forKey: .banner)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        productCount = try values.decodeIfPresent(Int.self, forKey: .productCount)
    }

}

//
//  Get_Category_Model.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 10/07/24.
//

import Foundation

struct Get_Faq_Category_Main : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : Get_Faq_Category_Data?

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
        data = try values.decodeIfPresent(Get_Faq_Category_Data.self, forKey: .data)
    }

}

struct Get_Faq_Category_Data : Codable {
    let category : [Get_Faq_Category_Category]?

    enum CodingKeys: String, CodingKey {

        case category = "category"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decodeIfPresent([Get_Faq_Category_Category].self, forKey: .category)
    }

}

struct Get_Faq_Category_Category : Codable {
    let _id : String?
    let name : String?
    let createdAt : String?
    let updatedAt : String?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case name = "name"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

}

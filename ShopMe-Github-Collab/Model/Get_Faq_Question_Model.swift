//
//  Get_Faq_by_Category_Model.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 10/07/24.
//

import Foundation

struct Get_Faq_Question_Main : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : Get_Faq_Question_Data?

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
        data = try values.decodeIfPresent(Get_Faq_Question_Data.self, forKey: .data)
    }

}

struct Get_Faq_Question_Data : Codable {
    let faq : [Get_Faq_Question_Faq]?

    enum CodingKeys: String, CodingKey {

        case faq = "faq"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        faq = try values.decodeIfPresent([Get_Faq_Question_Faq].self, forKey: .faq)
    }

}

struct Get_Faq_Question_Faq : Codable {
    let _id : String?
    let category : String?
    let question : String?
    let answer : String?
    let createdAt : String?
    let updatedAt : String?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case category = "category"
        case question = "question"
        case answer = "answer"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        question = try values.decodeIfPresent(String.self, forKey: .question)
        answer = try values.decodeIfPresent(String.self, forKey: .answer)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

}

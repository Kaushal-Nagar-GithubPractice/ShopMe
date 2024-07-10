//
//  EnquiryModel.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 09/07/24.
//

import Foundation
struct EnquiryModel : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : EnquiryData?

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
        data = try values.decodeIfPresent(EnquiryData.self, forKey: .data)
    }

}

struct EnquiryData : Codable {
    let name : String?
    let email : String?
    let subject : String?
    let message : String?
    let _id : String?
    let createdAt : String?
    let updatedAt : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case email = "email"
        case subject = "subject"
        case message = "message"
        case _id = "_id"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        subject = try values.decodeIfPresent(String.self, forKey: .subject)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

}

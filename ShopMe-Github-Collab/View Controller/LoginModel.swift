//
//  LoginModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 01/07/24.
//

import Foundation
struct Login_Struct : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : LoginData?

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
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)
    }

}

struct LoginData : Codable {
    let firstName : String?
    let lastName : String?
    let email : String?
    let token : String?
    let _id : String?

    enum CodingKeys: String, CodingKey {

        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case token = "token"
        case _id = "_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
    }

}

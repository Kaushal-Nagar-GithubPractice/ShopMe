//
//  ProfileModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 01/07/24.
//

import Foundation

struct Profile_Struct : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : ProfileData?

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
        data = try values.decodeIfPresent(ProfileData.self, forKey: .data)
    }

}

struct ProfileData : Codable {
    let _id : String?
    let firstName : String?
    let lastName : String?
    let email : String?
    let dob : String?
    let gender : String?
    let phone : Int?
    let profilePic : String?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case dob = "dob"
        case gender = "gender"
        case phone = "phone"
        case profilePic = "profilePic"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        phone = try values.decodeIfPresent(Int.self, forKey: .phone)
        profilePic = try values.decodeIfPresent(String.self, forKey: .profilePic)
    }

}

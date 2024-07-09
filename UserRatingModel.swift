//
//  UserRatingModel.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 05/07/24.
//

import Foundation
struct UserRatingModel : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : UserRating_List?

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
        data = try values.decodeIfPresent(UserRating_List.self, forKey: .data)
    }

}

struct UserRating_List : Codable {
    let reviews : [Reviews]?
    let page : Int?
    let items : Int?
    let total_count : Int?

    enum CodingKeys: String, CodingKey {

        case reviews = "reviews"
        case page = "page"
        case items = "items"
        case total_count = "total_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reviews = try values.decodeIfPresent([Reviews].self, forKey: .reviews)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        items = try values.decodeIfPresent(Int.self, forKey: .items)
        total_count = try values.decodeIfPresent(Int.self, forKey: .total_count)
    }

}

struct Reviews : Codable {
    let rating : Int?
    let review : String?
    let name : String?
    let createdAt : String?
    let profilePic : String?

    enum CodingKeys: String, CodingKey {

        case rating = "rating"
        case review = "review"
        case name = "name"
        case createdAt = "createdAt"
        case profilePic = "profilePic"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rating = try values.decodeIfPresent(Int.self, forKey: .rating)
        review = try values.decodeIfPresent(String.self, forKey: .review)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        profilePic = try values.decodeIfPresent(String.self, forKey: .profilePic)
    }

}

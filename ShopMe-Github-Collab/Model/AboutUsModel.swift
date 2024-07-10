//
//  AboutUsModel.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 10/07/24.
//

import Foundation
struct AboutUsModel : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : AboutUsData?

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
        data = try values.decodeIfPresent(AboutUsData.self, forKey: .data)
    }

}

struct AboutUsData : Codable {
    let shortDescription : String?
    let longDescription : String?
    let title : String?
    let image : String?

    enum CodingKeys: String, CodingKey {

        case shortDescription = "shortDescription"
        case longDescription = "longDescription"
        case title = "title"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        shortDescription = try values.decodeIfPresent(String.self, forKey: .shortDescription)
        longDescription = try values.decodeIfPresent(String.self, forKey: .longDescription)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }

}

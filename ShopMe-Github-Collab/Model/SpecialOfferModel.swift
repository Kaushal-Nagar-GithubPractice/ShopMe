//
//  SpecialOfferModel.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 09/07/24.
//

import Foundation
struct SpecialOfferModel : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : SpecialOfferData?

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
        data = try values.decodeIfPresent(SpecialOfferData.self, forKey: .data)
    }

}

struct SpecialOfferData : Codable {
    let specialOffers : [SpecialOffers]?

    enum CodingKeys: String, CodingKey {

        case specialOffers = "specialOffers"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        specialOffers = try values.decodeIfPresent([SpecialOffers].self, forKey: .specialOffers)
    }

}


struct SpecialOffers : Codable {
    let _id : String?
    let title : String?
    let description : String?
    let startDate : String?
    let endDate : String?
    let offerImage : String?
    let type : String?
    let value : Int?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case title = "title"
        case description = "description"
        case startDate = "startDate"
        case endDate = "endDate"
        case offerImage = "offerImage"
        case type = "type"
        case value = "value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        startDate = try values.decodeIfPresent(String.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(String.self, forKey: .endDate)
        offerImage = try values.decodeIfPresent(String.self, forKey: .offerImage)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        value = try values.decodeIfPresent(Int.self, forKey: .value)
    }

}

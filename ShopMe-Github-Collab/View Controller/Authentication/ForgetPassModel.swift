//
//  ForgetPassModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 05/07/24.
//

import Foundation

struct ForgetPass_Main : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case success = "success"
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}


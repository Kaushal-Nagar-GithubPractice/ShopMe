//
//  CouponModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 09/07/24.
//

import Foundation
import Foundation
struct CouponModel : Codable {
    let type : String?
    let success : Bool?
    let status : Int?
    let message : String?
    let data : Coupon_Data?

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
        data = try values.decodeIfPresent(Coupon_Data.self, forKey: .data)
    }

}

struct Coupon_Data : Codable {
    let _id : String?
    let couponCode : String?
    let startDate : String?
    let endDate : String?
    let discount : Int?
    let discountType : String?
    let users : [Users]?
    let perUserLimit : Int?
    let totalCoupon : Int?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case couponCode = "couponCode"
        case startDate = "startDate"
        case endDate = "endDate"
        case discount = "discount"
        case discountType = "discountType"
        case users = "users"
        case perUserLimit = "perUserLimit"
        case totalCoupon = "totalCoupon"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        couponCode = try values.decodeIfPresent(String.self, forKey: .couponCode)
        startDate = try values.decodeIfPresent(String.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(String.self, forKey: .endDate)
        discount = try values.decodeIfPresent(Int.self, forKey: .discount)
        discountType = try values.decodeIfPresent(String.self, forKey: .discountType)
        users = try values.decodeIfPresent([Users].self, forKey: .users)
        perUserLimit = try values.decodeIfPresent(Int.self, forKey: .perUserLimit)
        totalCoupon = try values.decodeIfPresent(Int.self, forKey: .totalCoupon)
    }

}
struct Users : Codable {
    let userId : String?
    let uses : Int?
    let _id : String?

    enum CodingKeys: String, CodingKey {

        case userId = "userId"
        case uses = "uses"
        case _id = "_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        uses = try values.decodeIfPresent(Int.self, forKey: .uses)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
    }

}

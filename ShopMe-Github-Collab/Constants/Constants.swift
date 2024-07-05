//
//  Constants.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 28/06/24.
//

import Foundation
let headerContentType =  "Content-Type"
let contentTypeUrlJSON =  "application/json"

//let API_BASE_URL = "https://reqres.in/api/"

class Constant {
//    static let GET_USER_LIST = API_BASE_URL + "users?page=1"
    //Prasiddh's Urls
    static let API_BASE_URL = "https://shoppingcart-api.demoserver.biz"
    static let getUserCart =  "\(API_BASE_URL)/cart"
    static let deleteProductFromCart = "\(API_BASE_URL)/cart"
    static let checkoutOrder = "\(API_BASE_URL)/order/checkout"
}

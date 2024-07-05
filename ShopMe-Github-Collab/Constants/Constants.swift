//
//  Constants.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 28/06/24.
//

import Foundation
let headerContentType =  "Content-Type"
let contentTypeUrlJSON =  "application/json"
let token = UserDefaults.standard.value(forKey: "token")
let API_BASE_URL = "https://shoppingcart-api.demoserver.biz"

class Constant {
    static let GET_PRODUCT_LIST = API_BASE_URL + "/product/list"
    static let GET_CATEGORY_LIST = API_BASE_URL + "/category/list"
    static let GET_RELATED_LIST = API_BASE_URL + "/product/related/"
    static let GET_PRODUCT = API_BASE_URL + "/product/"
    static let GET_SEARCHED_PRODUCT = GET_PRODUCT_LIST + "?search="
    static let ADD_TO_CART = API_BASE_URL + "/cart/"
    static let GET_ALL_CART_ITEMS = API_BASE_URL + "/cart"
    static let POST_PRODUCT_RATING = API_BASE_URL + "/review/"
}

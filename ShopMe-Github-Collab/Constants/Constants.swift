//
//  Constants.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 28/06/24.
//

import Foundation
let headerContentType =  "Content-Type"
let contentTypeUrlJSON =  "application/json"
let API_BASE_URL = "https://shoppingcart-api.demoserver.biz"

class Constant {
//    static let GET_USER_LIST = API_BASE_URL + "users?page=1"
    
    static let Register_User_URl = API_BASE_URL + "/user/registration"
    static let Login_User_URl = API_BASE_URL + "/user/login"
    static let Get_User_URl = API_BASE_URL + "/user"
    static let Update_User_URl = API_BASE_URL +	"/user/update"
    static let Get_OrderList_URl = API_BASE_URL + "/order/list"
}

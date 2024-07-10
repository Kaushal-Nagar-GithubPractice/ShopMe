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

    //Prasiddh's Urls
//    static let API_BASE_URL = "https://shoppingcart-api.demoserver.biz"?
    static let getUserCart =  "\(API_BASE_URL)/cart"
    static let deleteProductFromCart = "\(API_BASE_URL)/cart"
    static let checkoutOrder = "\(API_BASE_URL)/order/checkout"
    
    static let wishlistGet = "\(API_BASE_URL)/wishlist/"
    static let getCoupon = "\(API_BASE_URL)/coupon/"

    //Himanshu's URLs
    static let GET_PRODUCT_LIST = API_BASE_URL + "/product/list"
    static let GET_CATEGORY_LIST = API_BASE_URL + "/category/list"
    static let GET_RELATED_LIST = API_BASE_URL + "/product/related/"
    static let GET_PRODUCT = API_BASE_URL + "/product/"
    static let GET_SEARCHED_PRODUCT = GET_PRODUCT_LIST + "?search="
    static let ADD_TO_CART = API_BASE_URL + "/cart/"
    static let GET_ALL_CART_ITEMS = API_BASE_URL + "/cart"
    static let POST_PRODUCT_RATING = API_BASE_URL + "/review/"
    static let GET_REVIEW_LIST = API_BASE_URL + "/review/list/"
    static let GET_COLOR_LIST = API_BASE_URL + "/product/color"
    static let ADD_TO_WHISLIST = API_BASE_URL + "/wishlist/"
    static let GET_CATEGORY_PRODUCTS = API_BASE_URL + "/product/list?categoryId="
    static let GET_SPECIAL_OFFERS = API_BASE_URL + "/specialOffer"
    static let POST_ENQUIRY = API_BASE_URL + "/enquiry"
    static let GET_ABOUTUS = API_BASE_URL + "/pages/aboutUs"
    static let GET_HELP = API_BASE_URL + "/pages/help"
    

    //Kaushal's URLs
    static let Register_User_URl = API_BASE_URL + "/user/registration"
    static let Login_User_URl = API_BASE_URL + "/user/login"
    static let Get_User_URl = API_BASE_URL + "/user"
    static let Update_User_URl = API_BASE_URL +	"/user/update"
    static let Get_OrderList_URl = API_BASE_URL + "/order/list"
    static let Confirm_Email_URL = API_BASE_URL + "/user/confirm-email"
    static let Forget_Pass_URl = API_BASE_URL + "/user/forget-password/"
    static let Get_Wishlist_URL = API_BASE_URL + "/wishlist/"
    static let Delete_Product_From_Wishlist_URL = API_BASE_URL + "/wishlist/"
    static let Change_Pass_URl = API_BASE_URL + "/user/changePassword"
    static let Cancel_Order_URl = API_BASE_URL + "/order/cancel/"
    static let Get_Faq_Category = API_BASE_URL + "/faq/category"
    static let Get_Faq_Questions = API_BASE_URL + "/faq/"

}

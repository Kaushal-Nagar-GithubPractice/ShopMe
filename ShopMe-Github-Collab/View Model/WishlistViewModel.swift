//
//  WishlistViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 05/07/24.
//

import Foundation

class WishlistViewModel: NSObject{
    func getWishlistData(request: APIRequest, success successCallback:
                     @escaping (WishListmodel) -> Void,
                     error errorCallback: @escaping (Error?) -> Void){
        APIClient().perform(request) { (data,Error) in
            
            if let data = data {
                do {
                    
                    let json  = try? JSONSerialization.jsonObject(with: data)
                    
                    print(json)
                    let res = try JSONDecoder().decode(WishListmodel.self, from: data)
                    
                    print("===>wish list Response ===>",res)
                    successCallback(res)
                } catch {
                    
                    print("====>..inside catch",Error)
                    errorCallback(Error)
                }
            } else {
                print("====>..inside else ")
                errorCallback(Error)
            }
        }
    }
    
}

//class WishlistViewModel: NSObject{
//
//    func getWishlistData(request: APIRequest, success successCallback: @escaping (WishListmodel) -> Void, error errorCallback: @escaping (Error?) -> Void){ APIClient().perform(request) { (data,Error) in
//        if let data = data {
//            do {
//                var response = try JSONDecoder().decode(WishListmodel.self, from: data)
//
//                print(response)
//                successCallback(response)
//            } catch {
//                errorCallback(Error)
//            }
//        } else {
//            errorCallback(Error)
//        }
//    }
//    }
//
//}

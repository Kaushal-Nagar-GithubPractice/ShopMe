//
//  WishlistViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 05/07/24.
//

import Foundation

class WishlistViewModel:NSObject{
    func getWishlistData(request: APIRequest, success successCallback:
                     @escaping (WishListmodel) -> Void,
                     error errorCallback: @escaping (Error?) -> Void){
        APIClient().perform(request) { (data,Error) in
            
            if let data = data {
                do {
                    
                    let json  = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                    var res = try! JSONDecoder().decode(WishListmodel.self, from: data)
                    print("===> json resp ==>...",json)
                    print("===>wish list Response ===>",res as Any)
                    successCallback(res)
                } catch {
                    
                    print("====>..inside cath")
                    errorCallback(Error)
                }
            } else {
                print("====>..inside else ")
                errorCallback(Error)
            }
        }
    }
    
}

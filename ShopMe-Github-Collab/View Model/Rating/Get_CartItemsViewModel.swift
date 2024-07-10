//
//  Get_CartDetailsViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 04/07/24.
//

import Foundation

class Get_CartItemsViewModel : NSObject {
    static let ApiGetCart = Get_CartItemsViewModel()
    
    func getAddToCartData(request : APIRequest ,success successCallback : @escaping  (Get_CartItems)  -> Void,error errorCallback : @escaping (Error?) -> Void){
        
        APIClient().perform(request){(data,error) in
            if let data = data {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
//                    print(parsedData)
                    var response = try JSONDecoder().decode(Get_CartItems.self, from: data)
                    successCallback(response)
                }
                catch {
                    errorCallback(error)
                }
            }
            else{
                errorCallback(error)
            }
        }
        
    }
}

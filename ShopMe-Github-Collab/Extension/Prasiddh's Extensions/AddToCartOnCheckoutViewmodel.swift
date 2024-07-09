//
//  AddToCartOnCheckoutViewmodel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 03/07/24.
//

import Foundation

class AddProductsOnChekoutViewModel{
    
    func addproductOnCheckout(request: APIRequest, success successCallback:
                     @escaping (UserCartModel) -> Void,
                              error errorCallback: @escaping (Error?) -> Void){
        APIClient().perform(request) { (data,Error) in
            
            if let data = data {
                do {
                    
                    let json  = try? JSONSerialization.jsonObject(with: data)
                    let res = try JSONDecoder().decode(UserCartModel.self, from: data)
                    successCallback(res)
                } catch {
                    errorCallback(Error)
                }
            } else {
                errorCallback(Error)
            }
        }
    }
}

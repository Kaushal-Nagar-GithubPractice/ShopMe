//
//  ProductAddToCartViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 02/07/24.
//

import Foundation

class ProductAddToCartViewModel : NSObject {
    
    static let ApiAddToCart = ProductAddToCartViewModel()
    
    func getAddToCartData(request : APIRequest ,success successCallback : @escaping  (ProductAddToCart)  -> Void,error errorCallback : @escaping (Error?) -> Void){
        
        APIClient().perform(request){(data,error) in
            if let data = data {
                do {
                    var response = try JSONDecoder().decode(ProductAddToCart.self, from: data)
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

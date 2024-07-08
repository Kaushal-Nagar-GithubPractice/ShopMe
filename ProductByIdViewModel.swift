//
//  ProductByIdViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 02/07/24.
//

import Foundation

class ProductByIdViewModel : NSObject {
    
    static let ApiProductByID = ProductByIdViewModel()
    
    func getSingleProductData(request : APIRequest ,success successCallback : @escaping  (ProductById)  -> Void,error errorCallback : @escaping (Error?) -> Void){
        
        APIClient().perform(request){(data,error) in
            if let data = data {
                do {
                    var response = try JSONDecoder().decode(ProductById.self, from: data)
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

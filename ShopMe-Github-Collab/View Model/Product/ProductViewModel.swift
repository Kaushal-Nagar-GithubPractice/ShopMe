//
//  ProductViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 01/07/24.
//

import Foundation

class ProductViewModel : NSObject {
    
    static let ApiProduct = ProductViewModel()
    
    func getProductData(request : APIRequest ,success successCallback : @escaping  (Product)  -> Void,error errorCallback : @escaping (Error?) -> Void){
        
        APIClient().perform(request){(data,error) in
            if let data = data {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
//                    print("\nProduct JSON",parsedData)
                    let response = try JSONDecoder().decode(Product.self, from: data)
//                    print("\nProduct JSON",response)
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

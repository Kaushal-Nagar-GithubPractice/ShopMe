//
//  CategoryViewModal.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 01/07/24.
//

import Foundation

class CategoryViewModal : NSObject {
    
    static let ApiCategory = CategoryViewModal()
    
    func getCategoryData(request : APIRequest ,success successCallback : @escaping  (CategoryModel)  -> Void,error errorCallback : @escaping (Error?) -> Void){
        
        APIClient().perform(request){(data,error) in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(CategoryModel.self, from: data)
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

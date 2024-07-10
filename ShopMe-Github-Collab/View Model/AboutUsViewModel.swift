//
//  AboutUsViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 10/07/24.
//

import Foundation
class AboutUsViewModel : NSObject {
    
    static let ApiAboutUs = AboutUsViewModel()
    
    func getAboutUs(request : APIRequest ,success successCallback : @escaping  (AboutUsModel)  -> Void,error errorCallback : @escaping (Error?) -> Void){
        
        APIClient().perform(request){(data,error) in
            if let data = data {
                do {
                    
//                    let parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
//                    print("\nProduct JSON",parsedData)
                    let response = try JSONDecoder().decode(AboutUsModel.self, from: data)
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


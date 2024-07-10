//
//  SpecialOfferViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 09/07/24.
//

import Foundation
class SpecialOfferViewModel : NSObject {
    static let ApiSpecialOffer = SpecialOfferViewModel()
    
    func getSpecialOffer(request : APIRequest ,success successCallback : @escaping  (SpecialOfferModel)  -> Void,error errorCallback : @escaping (Error?) -> Void){
        
        APIClient().perform(request){(data,error) in
            if let data = data {
                do {
                    
//                    let parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
//                    print("\nProduct JSON",parsedData)
                    let response = try JSONDecoder().decode(SpecialOfferModel.self, from: data)
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

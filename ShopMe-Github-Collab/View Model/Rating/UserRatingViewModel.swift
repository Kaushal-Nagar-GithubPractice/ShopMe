//
//  UserRatingViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 05/07/24.
//

import Foundation

class UserRatingViewModel : NSObject {
    

static let ApiPostRatings = UserRatingViewModel()

func getPostRatingData(request : APIRequest ,success successCallback : @escaping  (UserRatingModel)  -> Void,error errorCallback : @escaping (Error?) -> Void){
    
    APIClient().perform(request){(data,error) in
        if let data = data {
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
//                print(parsedData)
                var response = try JSONDecoder().decode(UserRatingModel.self, from: data)
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

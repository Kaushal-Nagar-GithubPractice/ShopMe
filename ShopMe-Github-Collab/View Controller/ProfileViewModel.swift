//
//  ProfileViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 01/07/24.
//

import Foundation

class GetProfileDataViewModel : NSObject{
    
    func CallToGetProfileData(request: APIRequest, success successCallback: @escaping (Profile_Struct) -> Void, error errorCallback: @escaping (Error?) -> Void){ APIClient().perform(request) { (data,Error) in
        if let data = data {
            do {
                var response = try JSONDecoder().decode(Profile_Struct.self, from: data)
                
                print("\nProfile API Response\n",response)
                successCallback(response)
            } catch {
                errorCallback(Error)
            }
        } else {
            errorCallback(Error)
        }
    }
    }
    
}

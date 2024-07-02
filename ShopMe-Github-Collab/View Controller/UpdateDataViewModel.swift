//
//  UpdateDataViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 02/07/24.
//

import Foundation
class UpdateDataViewModel : NSObject{
    
    func CallToUpdateProfileData(request: APIRequest, success successCallback: @escaping (UpdateData_Struct) -> Void, error errorCallback: @escaping (Error?) -> Void){ APIClient().perform(request) { (data,Error) in
        if let data = data {
            do {
                var response = try JSONDecoder().decode(UpdateData_Struct.self, from: data)
                
                print("\nUpdate Profile API Response\n",response)
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

//
//  LoginViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 01/07/24.
//

import Foundation

class GetLoginDataViewModel : NSObject{
    
    func CallToLogin(request: APIRequest, success successCallback: @escaping (Login_Struct) -> Void, error errorCallback: @escaping (Error?) -> Void){ APIClient().perform(request) { (data,Error) in
        if let data = data {
            do {
                var response = try JSONDecoder().decode(Login_Struct.self, from: data)
                
                print("\nRegister Response From API\n",response)
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

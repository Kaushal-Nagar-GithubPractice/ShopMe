//
//  RegisterViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 01/07/24.
//

import Foundation

class GetRegisterDataViewModel: NSObject{
    
    func CallToGetRegister(request: APIRequest, success successCallback: @escaping (Register_Struct) -> Void, error errorCallback: @escaping (Error?) -> Void){ APIClient().perform(request) { (data,Error) in
        if let data = data {
            do {
                var response = try JSONDecoder().decode(Register_Struct.self, from: data)
                
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

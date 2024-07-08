//
//  ForgetPassViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 05/07/24.
//

import Foundation

class ForgetPassViewModel : NSObject{
    
    func CallToForgetPass(request: APIRequest, success successCallback: @escaping (ForgetPass_Main) -> Void, error errorCallback: @escaping (Error?) -> Void){ APIClient().perform(request) { (data,Error) in
        if let data = data {
            do {
                var response = try JSONDecoder().decode(ForgetPass_Main.self, from: data)
                
                print("\nForget Pass Response From API\n",response)
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

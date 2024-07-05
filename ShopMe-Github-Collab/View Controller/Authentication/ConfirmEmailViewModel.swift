//
//  ForgetPassViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 05/07/24.
//

import Foundation

class ConfirmEmailViewModel : NSObject{
    
    func CallToConfirmEmail(request: APIRequest, success successCallback: @escaping (ConfirmEmail_Main) -> Void, error errorCallback: @escaping (Error?) -> Void){ APIClient().perform(request) { (data,Error) in
        if let data = data {
            do {
                var response = try JSONDecoder().decode(ConfirmEmail_Main.self, from: data)
                
                print("\nConfirm Email Response From API\n",response)
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

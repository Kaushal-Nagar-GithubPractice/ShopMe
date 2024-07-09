//
//  ChangePassViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 08/07/24.
//

import Foundation

class ChangePassViewModel: NSObject{
    
    func CallToChangePass(request: APIRequest, success successCallback: @escaping (ChangePass_Main) -> Void, error errorCallback: @escaping (Error?) -> Void){ APIClient().perform(request) { (data,Error) in
        if let data = data {
            do {
                var response = try JSONDecoder().decode(ChangePass_Main.self, from: data)
                
                print(response)
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

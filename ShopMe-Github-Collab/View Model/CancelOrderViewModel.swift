//
//  CancelOrderViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 10/07/24.
//

import Foundation

class CancelOrderViewModel: NSObject{
    
    func CallToCancelOrde(request: APIRequest, success successCallback: @escaping (Cancel_Order_Main) -> Void, error errorCallback: @escaping (Error?) -> Void){ APIClient().perform(request) { (data,Error) in
        if let data = data {
            do {
                var response = try JSONDecoder().decode(Cancel_Order_Main.self, from: data)
                
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

//
//  GetFaqQueViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 10/07/24.
//

import Foundation

class GetFaqQueViewModel: NSObject{
    
    func CallToGetQuestion(request: APIRequest, success successCallback: @escaping (Get_Faq_Question_Main) -> Void, error errorCallback: @escaping (Error?) -> Void){ APIClient().perform(request) { (data,Error) in
        if let data = data {
            do {
                var response = try JSONDecoder().decode(Get_Faq_Question_Main.self, from: data)
                
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

//
//  GetFaqCategoryViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 10/07/24.
//

import Foundation

class GetFaqCategoryViewModel: NSObject{
    
    func CallToGetCategory(request: APIRequest, success successCallback: @escaping (Get_Faq_Category_Main) -> Void, error errorCallback: @escaping (Error?) -> Void){ APIClient().perform(request) { (data,Error) in
        if let data = data {
            do {
                var response = try JSONDecoder().decode(Get_Faq_Category_Main.self, from: data)
                
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

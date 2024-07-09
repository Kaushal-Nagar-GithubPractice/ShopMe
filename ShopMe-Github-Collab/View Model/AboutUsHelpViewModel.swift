//
//  AboutUsHelpViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 09/07/24.
//

import Foundation

class AboutUsHelpViewModel: NSObject{
    
    func CallToGetData(request: APIRequest, success successCallback: @escaping (AboutUs_Help_Main) -> Void, error errorCallback: @escaping (Error?) -> Void){ APIClient().perform(request) { (data,Error) in
        if let data = data {
            do {
                var response = try JSONDecoder().decode(AboutUs_Help_Main.self, from: data)
                
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

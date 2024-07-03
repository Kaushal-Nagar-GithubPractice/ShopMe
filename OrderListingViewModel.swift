//
//  OrderListingViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 03/07/24.
//

import Foundation
class OrderListingDataViewModel : NSObject{
    
    func CallToGetOrdersData(request: APIRequest, success successCallback: @escaping (OrderListing_Main) -> Void, error errorCallback: @escaping (Error?) -> Void){ APIClient().perform(request) { (data,Error) in
        if let data = data {
            do {
                var response = try JSONDecoder().decode(OrderListing_Main.self, from: data)
                
                print("\nOrder Listing API Response\n",response)
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

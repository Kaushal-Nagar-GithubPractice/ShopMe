//
//  UserCartViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 28/06/24.
//

import Foundation

class GetUserCartVM: NSObject {
    func getCartData(request: APIRequest, success successCallback:
                     @escaping (UserCartModel) -> Void,
                     error errorCallback: @escaping (Error?) -> Void){
        APIClient().perform(request) { (data,Error) in

            if let data = data {
                do {
                    
                    let json  = try? JSONSerialization.jsonObject(with: data)
                    let res = try JSONDecoder().decode(UserCartModel.self, from: data)

                    successCallback(res)
                } catch {
                    errorCallback(Error)
                }
            } else {
                errorCallback(Error)
            }
        }
    }
    
    func deleteProduct(request: APIRequest, success successCallback:
                     @escaping (UserCartModel) -> Void,
                     error errorCallback: @escaping (Error?) -> Void){
        APIClient().perform(request) { (data,Error) in
            
//            print("data in crtvm=======",data)
            if let data = data {
                do {
                    
                    let json  = try? JSONSerialization.jsonObject(with: data)
//                    print("JSON DAta------",json!)
                    let res = try JSONDecoder().decode(UserCartModel.self, from: data)
                    successCallback(res)
                } catch {
                    errorCallback(Error)
                }
            } else {
//                print("error inside else====")
                errorCallback(Error)
            }
        }
    }
}

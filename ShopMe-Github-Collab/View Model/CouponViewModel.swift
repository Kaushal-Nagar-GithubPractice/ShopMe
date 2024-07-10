//
//  CouponViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 09/07/24.
//

import Foundation

class CouponViewModel:NSObject{
    func getCouponDetails(request: APIRequest , success successCallBack : @escaping (CouponModel) -> Void , error errorCallBack : @escaping (Error?) -> Void ){
        
        APIClient().perform(request) { (data, Error) in
            if let data = data{
                do{
                    let response = try JSONDecoder().decode(CouponModel.self, from: data)
                    successCallBack(response)
                    
                }catch{
                    errorCallBack(error)
                    print("Something wrong while parsing Data.")
                }
                
            }else{
                errorCallBack(Error)
            }
        }
    }
}

//
//  Post_WishlistViewModel.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 05/07/24.
//

import Foundation
class Post_WishlistViewModel : NSObject {
    
    static let ApiAddWishlist = Post_WishlistViewModel()
    
    func getPostRatingData(request : APIRequest ,success successCallback : @escaping  (Post_WhislistModel)  -> Void,error errorCallback : @escaping (Error?) -> Void){
        
        APIClient().perform(request){(data,error) in
            if let data = data {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
//                    print(parsedData)
                    var response = try JSONDecoder().decode(Post_WhislistModel.self, from: data)
                    successCallback(response)
                }
                catch {
                    errorCallback(error)
                }
            }
            else{
                errorCallback(error)
            }
        }
        
    }
}


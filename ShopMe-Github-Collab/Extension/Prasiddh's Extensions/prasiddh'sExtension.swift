//
//  prasiddh'sExtension.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 03/07/24.
//

import Foundation
import UIKit
import Kingfisher

extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        return dateFormatter.string(from: Date())
    }
}

//set image using kingfisher
extension UIImageView {
    func setImage (imgUrl : String , imgView: UIImageView ){
        let url = URL(string: imgUrl)
        let processor = DownsamplingImageProcessor(size: imgView.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 0)
        imgView.kf.indicatorType = .activity
        imgView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "Placeholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
                imgView.image = UIImage(named: "Placeholder")
            }
        }
        
    }

}


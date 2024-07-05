//
//  Kaushal_Extension.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 03/07/24.
//

import Foundation
import UIKit
import Kingfisher

extension UIViewController {
    
    func SetImageRoundBorder(ImageView : UIImageView){
        let borderLayer = CALayer()
        borderLayer.frame = ImageView.bounds
        borderLayer.borderColor = UIColor.white.cgColor
        borderLayer.borderWidth = 8
        borderLayer.cornerRadius = borderLayer.frame.width / 2
        ImageView.layer.insertSublayer(borderLayer, above: ImageView.layer)
    }
    
    func ShowAlertBox(Title: String , Message : String){
        let Alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        
        Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            //            print("Handle Ok logic here")
            Alert.dismiss(animated: true)
        }))
        Alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.systemBackground
        Alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderWidth = 0.5
        Alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderColor = UIColor(named: "Custom Black")?.cgColor
        self.present(Alert, animated: true, completion: nil)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func getFormattedDate(DateInString: String , FromFormate:String , ToFormate : String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = FromFormate
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = ToFormate
        
        let date: Date? = dateFormatterGet.date(from: DateInString)
        print("Date",dateFormatterPrint.string(from: date ?? Date())) // Feb 01,2018
        return dateFormatterPrint.string(from: date ?? Date());
    }
    
    func ConvertStringToDate(formate : String , DateInString : String) -> Date {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = formate
        
        return dateFormatterGet.date(from: DateInString) ?? Date()
    }
}

extension UIView {
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) -> CALayer {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color
        borderLayer.lineWidth = 2
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        layer.addSublayer(borderLayer)
        return borderLayer
    }
}

extension UIImageView{
    func SetImageWithKingFisher(ImageUrl: String, imageView: UIImageView){
        let url = URL(string: ImageUrl)
        print("\nKingfisher Img URL",ImageUrl)
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 0)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder"),
            options: [
                KingfisherOptionsInfoItem
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.5)),
                .forceRefresh
//                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}

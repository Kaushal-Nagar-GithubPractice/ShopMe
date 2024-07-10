//
//  prasiddh'sExtension.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 03/07/24.
//

import Foundation
import UIKit
import Kingfisher
import SVProgressHUD

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

extension UIViewController{
    func customizeLoader(){
        SVProgressHUD.setBackgroundColor(UIColor(named:"Custom Black - h")!)
        SVProgressHUD.setForegroundColor(UIColor.black)
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        
        SVProgressHUD.setDefaultMaskType(.black)
    }
    
//    func registerKeyboardState(scrollingView : UIScrollView){
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
//        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
//        let keyboardSize = keyboardInfo.cgRectValue.size
//        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
//
//        scrollView.contentInset = contentInsets
//        scrollView.scrollIndicatorInsets = contentInsets
//        
//    }
//    
//    @objc func keyboardWillHide(notification: NSNotification) {
//        scrollView.contentInset = .zero
//        scrollView.scrollIndicatorInsets = .zero
//    }
}

extension UIView{
    func applyShadow(view : UIView){
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowRadius = 3.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
    }
}


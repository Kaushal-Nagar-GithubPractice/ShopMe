//
//  HimanshuExtension.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 03/07/24.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImageWithURL(url : String , imageView : UIImageView){
        let url = URL(string: url)
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
//                     |> RoundCornerImageProcessor(cornerRadius: 0)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ])
        {result in
            switch result {
            case .success(let value):
//                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                break
            case .failure(let error):
//                print("Job failed: \(error.localizedDescription)")
                break
            }
        }
    }
}


@IBDesignable
extension UIView
{

    @IBInspectable
    public var cornerRadius: CGFloat
    {
        set (radius) {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = radius > 0
        }

        get {
            return self.layer.cornerRadius
        }
    }

    @IBInspectable
    public var borderWidth: CGFloat
    {
        set (borderWidth) {
            self.layer.borderWidth = borderWidth
        }

        get {
            return self.layer.borderWidth
        }
    }

    @IBInspectable
    public var borderColor:UIColor?
    {
        set (color) {
            self.layer.borderColor = color?.cgColor
        }

        get {
            if let color = self.layer.borderColor
            {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }
}
@IBDesignable
extension UIButton
{

    @IBInspectable
    public  var BtncornerRadius: CGFloat
    {
        set (radius) {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = radius > 0
        }

        get {
            return self.layer.cornerRadius
        }
    }

    @IBInspectable
    public  var BtnborderWidth: CGFloat
    {
        set (borderWidth) {
            self.layer.borderWidth = borderWidth
        }

        get {
            return self.layer.borderWidth
        }
    }

    @IBInspectable
    public  var BtnborderColor:UIColor?
    {
        set (color) {
            self.layer.borderColor = color?.cgColor
        }

        get {
            if let color = self.layer.borderColor
            {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }
}

@IBDesignable
extension UILabel
{

    @IBInspectable
    public  var LblcornerRadius: CGFloat
    {
        set (radius) {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = radius > 0
        }

        get {
            return self.layer.cornerRadius
        }
    }

    @IBInspectable
    public  var LblborderWidth: CGFloat
    {
        set (borderWidth) {
            self.layer.borderWidth = borderWidth
        }

        get {
            return self.layer.borderWidth
        }
    }

    @IBInspectable
    public  var LblborderColor:UIColor?
    {
        set (color) {
            self.layer.borderColor = color?.cgColor
        }

        get {
            if let color = self.layer.borderColor
            {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }
}
extension UIView{
    func ApplyShadow(view: UIView){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 01.0, height: 01.0)
        view.layer.shadowRadius = 3.0
        view.layer.masksToBounds = false
        
    }
}

extension String {
    func htmlToAttributedString(fontName: String = "SpaceGrotesk-Regular", fontSize: Float = 14) -> NSAttributedString? {
            let style = "<style>body {font-size:\(fontSize)px; }</style>"
            guard let data = (self + style).data(using: .utf8) else {
                return nil
            }
            return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
}

extension UIViewController {
    
    
    func GregisterKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(GkeyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(GkeyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        
    }
//    
//    @objc func GkeyboardWillShow(notification: NSNotification ) {
//        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
//        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
//        let keyboardSize = keyboardInfo.cgRectValue.size
//        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
//        Global_scrollView?.contentInset = contentInsets
//        Global_scrollView?.scrollIndicatorInsets = contentInsets
//    }
//    
//    @objc func GkeyboardWillHide(notification: NSNotification) {
//        Global_scrollView?.contentInset = .zero
//        Global_scrollView?.scrollIndicatorInsets = .zero
//    }
    
    
    @objc private func GkeyboardWillShow(notification: NSNotification){
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        Global_scrollView?.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height + 15
    }
    
    @objc private func GkeyboardWillHide(notification: NSNotification){
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        Global_scrollView?.contentInset.bottom = 0
    }
}


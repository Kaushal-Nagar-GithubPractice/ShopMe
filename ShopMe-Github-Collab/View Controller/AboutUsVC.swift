//
//  AboutUsVC.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 10/07/24.
//

import UIKit
import SVProgressHUD
import WebKit

class AboutUsVC: UIViewController {
    
    @IBOutlet var viewInsideScroll: UIView!
    @IBOutlet var webView: WKWebView!
    var isHelp = false
    @IBOutlet weak var lblLongDesc: UILabel!
    @IBOutlet weak var lblShortDesc: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var responseData : AboutUsData?
    var navTitle = "About Us"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
       
        setUpMenuButton(isScroll: true)
        callApiAboutUs()
//        let prefs = WKPreferences()
//        prefs.javaScriptEnabled = true
//        let pagePrefs = WKWebpagePreferences()
//        pagePrefs.allowsContentJavaScript = true
//        let config = WKWebViewConfiguration()
//        config.preferences = prefs
//        config.defaultWebpagePreferences = pagePrefs
//        webView = WKWebView(frame: .zero, configuration: config)
//        webView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            webView.topAnchor.constraint(equalTo: lblLongDesc.bottomAnchor, constant: 15),
//            webView.bottomAnchor.constraint(equalTo: viewInsideScroll.bottomAnchor, constant: 15),
//            webView.leadingAnchor.constraint(equalTo: viewInsideScroll.leadingAnchor, constant: 15),
//            webView.trailingAnchor.constraint(equalTo: viewInsideScroll.trailingAnchor, constant: 15)
//            
//        ])
//        webView.loadHTMLString("<!DOCTYPE html><html><head>Loading HTML</head><body><p>Hello!</p></body></html>", baseURL: nil)
    }
    
    func callApiAboutUs(){
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        var requestAboutUs = APIRequest(isLoader: true, method: HTTPMethods.get, path: Constant.GET_ABOUTUS
                                        , headers: HeaderValue.headerWithoutAuthToken.value, body: nil)
        if isHelp {
             requestAboutUs = APIRequest(isLoader: true, method: HTTPMethods.get, path: Constant.GET_HELP, headers: HeaderValue.headerWithoutAuthToken.value, body: nil)
        }
        AboutUsViewModel.ApiAboutUs.getAboutUs(request: requestAboutUs) { response in
            DispatchQueue.main.async {
                if response.status == 200 && response.success == true {
                    self.responseData = response.data
                    self.setUpAfterApiCaling()
                    SVProgressHUD.dismiss()
                }
                else{
                    SVProgressHUD.dismiss()
                    self.ShowAlertBox(Title: "Alert", Message: "Something wennt Wrong")
                }
            }
        } error: { error in
            print(error as Any)
            SVProgressHUD.dismiss()
        }

    }
    func setUpAfterApiCaling(){
        if isHelp{
            navTitle = "Help"
        }
        else{
            navTitle = "About Us"
        }
        imageView.setImageWithURL(url: responseData?.image ?? "", imageView: imageView)
        lblShortDesc.text = responseData?.shortDescription
        lblLongDesc.attributedText = responseData?.longDescription?.htmlToAttributedString(fontSize: 20)
        
        self.navigationItem.title = navTitle
    }
    
    func setUpMenuButton(isScroll: Bool) {
        let icon = UIImage(systemName: "chevron.left")
        let iconSize = CGRect(origin: CGPoint.init(x: 0, y: 0), size: CGSize(width: 20, height: 25))
        let iconButton = UIButton(frame: iconSize)
        iconButton.tintColor = isScroll ? .label : .label
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(btnBackClicked), for: .touchUpInside)
        navigationItem.leftBarButtonItem = barButton
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)]
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc func btnBackClicked(){
        self.navigationController?.popViewController(animated: true)
    }
}

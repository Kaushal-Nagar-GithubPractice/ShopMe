//
//  ContactUsVC.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 09/07/24.
//

import UIKit
import KMPlaceholderTextView
import SVProgressHUD

class ContactUsVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtviewMessage: KMPlaceholderTextView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfSubject: UITextField!
    @IBOutlet weak var tfName: UITextField!
    
    //MARK: - APPLICATION DELEGATE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    override func viewWillAppear(_ animated: Bool) {
        GregisterKeyboardNotifications()
        Global_scrollView = scrollView
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        txtviewMessage.placeholder = " Enter your Message here *"
        txtviewMessage.layer.cornerRadius = 5
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK: - @IBACTION METHODS
    
    @IBAction func onClickbtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onClickSendEnquiry(_ sender: Any) {
        if !(txtviewMessage.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) && !((tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) == nil) && (isValidEmail(email: tfEmail.text ?? "")) &&
            !((tfSubject.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) == nil) {
            let dict = [
                "name":tfName.text ?? "",
                "email":tfEmail.text ?? "",
                "subject":tfSubject.text ?? "",
                "message":txtviewMessage.text
            ] as [String:String]
            
            callApiEnquiry(dict : dict)
        }
        else{
            ShowAlertBox(Title: "Alert", Message: "Please Enter Correct Data")
        }
    }
    
    //MARK: - Api Calling Functions
    
    func callApiEnquiry(dict : [String:String]){
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        let requestEnquiry = APIRequest(isLoader: true, method: HTTPMethods.post, path: Constant.POST_ENQUIRY, headers: HeaderValue.headerWithoutAuthToken.value, body: dict)
        EnquiryViewModel.ApiPostEnquiry.postEnquiry(request: requestEnquiry) { response in
            DispatchQueue.main.async {
                if response.status == 200 && response.success == true {
                    self.ShowAlertBox(Title: "Confirmation", Message: "\(response.message ?? "")")
                    self.tfName.text = ""
                    self.tfEmail.text = ""
                    self.tfSubject.text = ""
                    self.txtviewMessage.text = ""
                    SVProgressHUD.dismiss()
                }
                else{
                    SVProgressHUD.dismiss()
                    self.ShowAlertBox(Title: "Alert", Message: "Something went wrong")
                }
            }
        } error: { error in
            print(error as Any)
        }

    }
}

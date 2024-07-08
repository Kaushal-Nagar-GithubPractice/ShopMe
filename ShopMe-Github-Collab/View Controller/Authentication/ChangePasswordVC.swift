//
//  ChangePasswordVC.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 08/07/24.
//

import UIKit
import SVProgressHUD

class ChangePasswordVC: UIViewController {
    
    
    
    var changePassViewModel = ChangePassViewModel()
    var ChangePassResponse: ChangePass_Main?
    let loader = SVProgressHUD.self
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var TfOldPassword: UITextField!
    @IBOutlet weak var TfNewPassword: UITextField!
    @IBOutlet weak var TfNewConfirmPassword: UITextField!
    
    @IBOutlet weak var btnShowOldPassword: UIButton!
    @IBOutlet weak var btnShowNewPassword: UIButton!
    @IBOutlet weak var btnShowNewConfiPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        SetUI()
        registerKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - All IBActions
    
    @IBAction func OnClickCloseChangePassword(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func OnClickChangePassword(_ sender: Any) {
        
        if(TfNewPassword.text?.count == 0 || TfOldPassword.text?.count == 0 || TfNewConfirmPassword.text?.count == 0 ){
            ShowAlertBox(Title: "No field should be Empty !", Message: "")
        }
        else if( TfNewPassword.text?.count ?? 0 <= 8 || TfOldPassword.text?.count ?? 0 <= 8 || TfNewConfirmPassword.text?.count ?? 0 <= 8 ){
            ShowAlertBox(Title: "Password length should be More than 8 !", Message: "")
        }
        else if ( TfNewPassword.text?.trimmingCharacters(in: .whitespaces) != TfNewConfirmPassword.text?.trimmingCharacters(in: .whitespaces)){
            ShowAlertBox(Title: "Password & Confirm Password must be same.", Message: "")
        }
        else{
            CallAPIToChangePassword()
        }
    }
    
    
    @IBAction func OnClickShowAndHideOldPassword(_ sender: Any) {
        
        if btnShowOldPassword.isSelected{
            TfOldPassword.isSecureTextEntry = true
            btnShowOldPassword.isSelected = false
        }
        else{
            TfOldPassword.isSecureTextEntry = false
            btnShowOldPassword.isSelected = true
        }
    }
    
    @IBAction func OnClickShowAndHideNewPassword(_ sender: Any) {
        if btnShowNewPassword.isSelected{
            TfNewPassword.isSecureTextEntry = true
            btnShowNewPassword.isSelected = false
        }
        else{
            TfNewPassword.isSecureTextEntry = false
            btnShowNewPassword.isSelected = true
        }
    }
    
    @IBAction func OnClickShowAndHideNewConfiPassword(_ sender: Any) {
        if btnShowNewConfiPassword.isSelected{
            TfNewConfirmPassword.isSecureTextEntry = true
            btnShowNewConfiPassword.isSelected = false
        }
        else{
            TfNewConfirmPassword.isSecureTextEntry = false
            btnShowNewConfiPassword.isSelected = true
        }
    }
    
    
    
    
    //MARK: - All Defined Fucntions
    
    func SetUI(){
        TfOldPassword.text = ""
        TfNewPassword.text = ""
        TfNewConfirmPassword.text = ""
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        btnShowOldPassword.isSelected = false
        btnShowNewPassword.isSelected = false
        btnShowNewConfiPassword.isSelected = false
        
        btnShowNewPassword.setImage(UIImage(named: "Password Hide"), for: .normal)
        btnShowNewPassword.setImage(UIImage(named: "Password Show"), for: .selected)
        
        btnShowOldPassword.setImage(UIImage(named: "Password Hide"), for: .normal)
        btnShowOldPassword.setImage(UIImage(named: "Password Show"), for: .selected)
        
        btnShowNewConfiPassword.setImage(UIImage(named: "Password Hide"), for: .normal)
        btnShowNewConfiPassword.setImage(UIImage(named: "Password Show"), for: .selected)
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func CallAPIToChangePassword(){
        
        let ChangePassBody = ["oldPassword" : TfOldPassword.text , "newPassword" : TfNewPassword.text , "confirmPassword" : TfNewConfirmPassword.text]
        
        loader.show(withStatus: "Wait! While We are Changing Your PassWord")
        
        var request =  APIRequest(isLoader: true, method: .post, path: Constant.Change_Pass_URl, headers: HeaderValue.headerWithToken.value, body: ChangePassBody as [String : Any])
        
        changePassViewModel.CallToChangePass(request: request) { response in
            
            self.ChangePassResponse = response
            DispatchQueue.main.async { [self] in
                //Execute UI Code on Completion of API Call and getting data
                if ChangePassResponse?.success == true{
                    
                    let Alert = UIAlertController(title: "Password Changed Successfully !! \nPlease Login Again with your New Password!!", message: "", preferredStyle: UIAlertController.Style.alert)
                    
                    Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        //            print("Handle Ok logic here")
                        UserDefaults.standard.set("", forKey: "token")
                        UserDefaults.standard.set("", forKey: "IsRedirect")
                        self.navigationController?.popViewController(animated: true)
                        Alert.dismiss(animated: true)
                    }))
                    Alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.systemBackground
                    Alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderWidth = 0.5
                    Alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderColor = UIColor(named: "Custom Black")?.cgColor
                    self.present(Alert, animated: true, completion: nil)
                    
                }
                else{
                    ShowAlertBox(Title:  ChangePassResponse?.message ?? "", Message: "")
                }
                
                loader.dismiss()
            }
        } error: { error in
            print("========== API Error :",error)
            self.loader.dismiss()
        }
        
        
    }
 
    //MARK: - All Objc Functions
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}

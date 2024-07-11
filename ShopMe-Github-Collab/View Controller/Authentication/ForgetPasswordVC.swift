//
//  ForgetPasswordVC.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 05/07/24.
//

import UIKit
import SVProgressHUD

class ForgetPasswordVC: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var confirmEmailViewModel = ConfirmEmailViewModel()
    var ConfirmEmailResponse: ConfirmEmail_Main?
    let loader = SVProgressHUD.self
    
    var forgetPassViewModel = ForgetPassViewModel()
    var ForgetPassResponse: ForgetPass_Main?
    
    @IBOutlet weak var TfConfirmPassword: UITextField!
    @IBOutlet weak var TfPassword: UITextField!
    @IBOutlet weak var TfEmail: UITextField!
    
    @IBOutlet weak var btnShowPassword: UIButton!
    var DoShowPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        SetUI()
        GregisterKeyboardNotifications()
        Global_scrollView = scrollView
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - All IBActions
    
    
    @IBAction func OnClickCloseForgetPassword(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func OnClickChangePassword(_ sender: Any) {
        
        if(TfEmail.text?.count == 0 || TfPassword.text?.count == 0 || TfConfirmPassword.text?.count == 0 ){
            ShowAlertBox(Title: "Something Went Wrong!", Message: "No field should be Empty !")
        }
        else if(!isValidEmail(email: TfEmail.text ?? "")){
            ShowAlertBox(Title: "Something Went Wrong!", Message: "Enter Valid Email !")
        }
        else if( TfPassword.text?.count ?? 0 <= 8 ){
            ShowAlertBox(Title: "Something Went Wrong!", Message: "Password length should be More than 8 !")
        }
        else if ( TfPassword.text?.trimmingCharacters(in: .whitespaces) != TfConfirmPassword.text?.trimmingCharacters(in: .whitespaces)){
            ShowAlertBox(Title: "Something Went Wrong!", Message: "Password & Confirm Password should be same.")
        }
        else{
            CallApiAndChangePassword()
        }
        
    }
    
    
    @IBAction func OnClickShowAndHidePassword(_ sender: Any) {
        if DoShowPassword{
            DoShowPassword = false
            btnShowPassword.setImage(UIImage(named: "Password Hide"), for: .normal)
            TfPassword.isSecureTextEntry = true
            TfConfirmPassword.isSecureTextEntry = true
        }
        else{
            DoShowPassword = true
            btnShowPassword.setImage(UIImage(named: "Password Show"), for: .normal)
            TfPassword.isSecureTextEntry = false
            TfConfirmPassword.isSecureTextEntry = false
        }
    }
    
    //MARK: - All Defined Functions

    func CallApiAndChangePassword(){
        
        loader.show(withStatus: "Getting Your Email Info...")
        
        var request =  APIRequest(isLoader: true, method: .post, path: Constant.Confirm_Email_URL, headers: HeaderValue.headerWithoutAuthToken.value, body: ["email" : TfEmail.text?.lowercased().trimmingCharacters(in: .whitespaces)])
        
        confirmEmailViewModel.CallToConfirmEmail(request: request) { response in
            
            self.ConfirmEmailResponse = response
            DispatchQueue.main.async { [self] in
                //Execute UI Code on Completion of API Call and getting data
                
                if (ConfirmEmailResponse?.success == true){
                    UserDefaults.standard.set(ConfirmEmailResponse?.data?.token, forKey: "token")
                    
                    CallChangePasswordAPI()
                }
                else{
                    ShowAlertBox(Title: "Something Went Wrong!", Message: ConfirmEmailResponse?.message ?? "")
                }
                
                loader.dismiss()
            }
        } error: { error in
            print("========== API Error :",error)
            self.loader.dismiss()
        }
    }
    
    
    func CallChangePasswordAPI(){
        
        let Token = UserDefaults.standard.string(forKey: "token") ?? ""
        loader.show(withStatus: "Wait! \nWhile We are Changing Your Password...")
        
        var request =  APIRequest(isLoader: true, method: .post, path: Constant.Forget_Pass_URl + Token , headers: HeaderValue.headerWithoutAuthToken.value, body: ["password" : TfPassword.text ?? "" , "confirmPassword" : TfConfirmPassword.text ?? ""])
        
        forgetPassViewModel.CallToForgetPass(request: request) { response in
            
            self.ForgetPassResponse = response
            DispatchQueue.main.async { [self] in
                //Execute UI Code on Completion of API Call and getting data
                if (ForgetPassResponse?.success == true){
                    
                    let Alert = UIAlertController(title: ForgetPassResponse?.message ?? "", message: "", preferredStyle: UIAlertController.Style.alert)
                    
                    Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        //            print("Handle Ok logic here")
                        self.navigationController?.popViewController(animated: true)
                        Alert.dismiss(animated: true)
                    }))
                    Alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.systemBackground
                    Alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderWidth = 0.5
                    Alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderColor = UIColor(named: "Custom Black")?.cgColor
                    self.present(Alert, animated: true, completion: nil)
                    
                }
                else{
                    ShowAlertBox(Title: "Something Went Wrong!", Message: ForgetPassResponse?.message ?? "")
                }
                
                loader.dismiss()
            }
        } error: { error in
            print("========== API Error :",error)
            self.loader.dismiss()
        }
    }
    
    func SetUI(){
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
}

//
//  LoginScreenVC.swift
//  Github_Collab_Task
//
//  Created by webcodegenie on 19/06/24.
//

import UIKit
import SVProgressHUD

class LoginScreenVC: UIViewController {
    
    var getLoginDataVM = GetLoginDataViewModel()
    var LoginDataArr: Login_Struct!
    let loader = SVProgressHUD.self
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        TfEmail.text = ""
        TfPassword.text = ""
        
        //        print("\nEmail :", UserDefaults.standard.string(forKey: "Email") ?? "", "\nPassword :",UserDefaults.standard.string(forKey: "Password") ?? "", "\nIsRedirect :",UserDefaults.standard.bool(forKey: "IsRedirect"))
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - All IBActions
    
    @IBAction func OnClickShowAndHidePassword(_ sender: Any) {
        if DoShowPassword{
            DoShowPassword = false
            btnShowPassword.setImage(UIImage(named: "Password Hide"), for: .normal)
            TfPassword.isSecureTextEntry = true
        }
        else{
            DoShowPassword = true
            btnShowPassword.setImage(UIImage(named: "Password Show"), for: .normal)
            TfPassword.isSecureTextEntry = false
        }
    }
    
    @IBAction func OnClickLogin(_ sender: Any) {
        
        if(TfEmail.text?.count == 0 || TfPassword.text?.count == 0){
            ShowAlertBox(Title: "No field should be Empty !", Message: "")
        }
        else{
            CallApiToLogin()
        }
    }
    
    @IBAction func OnClickOpenRegisterScreen(_ sender: Any) {
        let RegisterScreenObj = self.storyboard?.instantiateViewController(withIdentifier: "RegisterScreenVC") as! RegisterScreenVC
        
        self.navigationController?.pushViewController(RegisterScreenObj, animated: true)
    }
    
    //MARK: - All Defined Functions
    
    func LoginSuccessfull(Response : Login_Struct){
        UserDefaults.standard.set(true, forKey: "IsRedirect")
        UserDefaults.standard.set(Response.data?.token, forKey: "token")
        print("\n====================\n")
        print("\nCurrent Token :\n",Response.data?.token)
        
        let Alert = UIAlertController(title: "Success!", message: "Login Successfull!", preferredStyle: UIAlertController.Style.alert)
        
        Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            //            print("Handle Ok logic here")
            self.navigationController?.popViewController(animated: true)
            Alert.dismiss(animated: true)
        }))
        Alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.systemBackground
        Alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderWidth = 0.5
        Alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderColor = UIColor(named: "Custom Black")?.cgColor
        self.present(Alert, animated: true, completion: nil)
        
        //        ShowAlertBox(Title: "Login Successfull!", Message: "")
    }
    
    func UpdateUI(){
        if LoginDataArr.success!{
            LoginSuccessfull(Response: LoginDataArr)
        }
        else{
            ShowAlertBox(Title: "Something Went Wrong!", Message: LoginDataArr.message ?? "")
        }
    }
    
    func CallApiToLogin(){
        
        let Body = ["email" : TfEmail.text?.lowercased().trimmingCharacters(in: .whitespaces),
                    "password" : TfPassword.text?.trimmingCharacters(in: .whitespaces)]
        
        loader.show(withStatus: "Login In Progress...")
        
        var request =  APIRequest(isLoader: true, method: .post, path: Constant.Login_User_URl, headers: HeaderValue.headerWithoutAuthToken.value, body: Body)
        
        getLoginDataVM.CallToLogin(request: request) { response in
            
            self.LoginDataArr = response
            DispatchQueue.main.async { [self] in
                //Execute UI Code on Completion of API Call and getting data
                print("\nAPI Response\n",response)
                UpdateUI()
                loader.dismiss()
            }
        } error: { error in
            print("\n========== Login API Error :",error)
            self.loader.dismiss()
        }
    }
    
    
    func SetUI(){
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        registerKeyboardNotifications()
        
        DoShowPassword = false
        btnShowPassword.setImage(UIImage(named: "Password Hide"), for: .normal)
        TfPassword.isSecureTextEntry = true
        btnLogin.layer.cornerRadius = 15
        loader.setDefaultMaskType(.black)
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

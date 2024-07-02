//
//  RegisterScreenVC.swift
//  Github_Collab_Task
//
//  Created by webcodegenie on 19/06/24.
//

import UIKit
import SVProgressHUD

class RegisterScreenVC: UIViewController {
    
    var GetRegisterDataVM = GetRegisterDataViewModel()
    var RegisterDataArr: Register_Struct!
    let loader = SVProgressHUD.self
    
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var TfEmail: UITextField!
    @IBOutlet weak var TfPassword: UITextField!
    @IBOutlet weak var TfConfirmPassword: UITextField!
    @IBOutlet weak var TfEnterName: UITextField!
    @IBOutlet weak var TfEnterLastName: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btnShowPassword: UIButton!
    var DoShowPassword = false
    
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
    
    @IBAction func OnClickRegisterUser(_ sender: Any) {
        
        if(TfEmail.text?.count == 0 || TfPassword.text?.count == 0 || TfConfirmPassword.text?.count == 0 || TfEnterName.text?.count == 0 || TfEnterLastName.text?.count == 0){
            ShowAlertBox(Title: "No field should be Empty !", Message: "")
        }
        else if(!isValidEmail(email: TfEmail.text ?? "")){
            ShowAlertBox(Title: "Enter Valid Email !", Message: "")
        }
        else if( TfPassword.text?.count ?? 0 <= 8 ){
            ShowAlertBox(Title: "Password length should be More than 8 !", Message: "")
        }
        else if ( TfPassword.text?.trimmingCharacters(in: .whitespaces) != TfConfirmPassword.text?.trimmingCharacters(in: .whitespaces)){
            ShowAlertBox(Title: "Password & Confirm Password should be same.", Message: "")
        }
        else{
            RegisterUser()
            //            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func OnClickGotoLoginScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - All Defined Functions
    
    func RegisterUser(){
        CallApiToRegisterUser()
        
        //        UserDefaults.standard.set(TfEnterName.text?.trimmingCharacters(in: .whitespaces), forKey: "Username")
        //        UserDefaults.standard.set(TfEmail.text?.lowercased(), forKey: "Email")
        //        UserDefaults.standard.set(TfPassword.text?.trimmingCharacters(in: .whitespaces), forKey: "Password")
        //        UserDefaults.standard.set(false, forKey: "IsRedirect")
    }
    
    func SetUI(){
        TfEmail.text = ""
        TfPassword.text = ""
        TfEnterName.text = ""
        TfConfirmPassword.text = ""
        btnRegister.layer.cornerRadius = 10
        DoShowPassword = false
        btnShowPassword.setImage(UIImage(named: "Password Hide"), for: .normal)
        TfPassword.isSecureTextEntry = true
        TfConfirmPassword.isSecureTextEntry = true
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
    
    func CallApiToRegisterUser() {
        let Body = [
            "firstName" : TfEnterName.text?.trimmingCharacters(in: .whitespaces),
            "lastName" : TfEnterLastName.text?.trimmingCharacters(in: .whitespaces),
            "email" : TfEmail.text?.lowercased().trimmingCharacters(in: .whitespaces),
            "password" : TfPassword.text?.trimmingCharacters(in: .whitespaces)]
        
        loader.show(withStatus: "Registration In Progress...")
        
        var request =  APIRequest(isLoader: true, method: .post, path: Constant.Register_User_URl, headers: HeaderValue.headerWithToken.value, body: Body)
        
        GetRegisterDataVM.CallToGetRegister(request: request) { response in
            
            self.RegisterDataArr = response
            DispatchQueue.main.async { [self] in
                //Execute UI Code on Completion of API Call and getting data
                UpdateUIData()
                self.loader.dismiss()
            }
        } error: { error in
            //            print("\n========== Register API Error :",error)
            self.loader.dismiss()
        }
    }
    
    func UpdateUIData(){
        
        if RegisterDataArr.success!{
            let Alert = UIAlertController(title: "Success!", message: RegisterDataArr.message ?? "", preferredStyle: UIAlertController.Style.alert)
            
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
            ShowAlertBox(Title: "Something Went Wrong!", Message: RegisterDataArr.message ?? "")
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

extension UIViewController{
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
}

import Kingfisher

extension UIImageView{
    func SetImageWithKingFisher(ImageUrl: String, imageView: UIImageView){
        let url = URL(string: ImageUrl)
        print("\nKingfisher Img URL",ImageUrl)
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "person.circle.fill"),
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
            }
        }
    }
}

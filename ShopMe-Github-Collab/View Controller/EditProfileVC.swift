//
//  EditProfileVC.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit
import SVProgressHUD
import Kingfisher
import Alamofire
//import UniformTypeIdentifiers
//import MobileCoreServices

class EditProfileVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var getUpdateDataViewModel = UpdateDataViewModel()
    var ProfileData : UpdateData_Struct!
    let loader = SVProgressHUD.self
    let dispatchGroup = DispatchGroup()
    
    let imagePicker = UIImagePickerController()
    var SelectedImage : UIImage!
    @IBOutlet weak var btnUpdate: UIButton!
    
    @IBOutlet weak var btnGenderFemale: UIButton!
    @IBOutlet weak var btnGenderMale: UIButton!
    @IBOutlet weak var imgProfilePicImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var TfFirstName: UITextField!
    @IBOutlet weak var TfPhoneNumber: UITextField!
    @IBOutlet weak var TfDOB: UITextField!
    @IBOutlet weak var TfLastName: UITextField!
    var BodyDict : [String : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.TappedOnImage(_:)))
        imgProfilePicImage.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SetUI()
        SetupRadioButton()
        registerKeyboardNotifications()
        btnUpdate.layer.cornerRadius = 10
        self.tabBarController?.tabBar.isHidden =  true
        //        TfName.text = UserDefaults.standard.string(forKey: "Username")
        //        TfPassword.text = UserDefaults.standard.string(forKey: "Password")
        //        TfEmail.text = UserDefaults.standard.string(forKey: "Email")
    }
    override func viewDidAppear(_ animated: Bool) {
        CallUpdateDataAPI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            SelectedImage = pickedImage
            imgProfilePicImage.image = SelectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - All IBAction
    
    @IBAction func OnClickUpdate(_ sender: Any) {
        
        if (TfFirstName.text?.count == 0 || TfLastName.text?.count == 0){
            ShowAlertBox(Title: "Field marked as * should not be Empty !", Message: "")
        }
        else if ( !btnGenderMale.isSelected && !btnGenderFemale.isSelected){
            ShowAlertBox(Title: "Select Gender Please", Message: "")
        }
        else{
            
            dispatchGroup.enter()
            UpdateProfile()
            
            dispatchGroup.enter()
            ShowAlertBox(Title: ProfileData.message ?? "", Message: "")
            
            dispatchGroup.notify(queue: .main) {
                print("all activities complete 👍")
            }
        }
    }
    
    @IBAction func OnClickCloseEditProfile(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func OnClickSelectGender(_ sender: Any) {
        btnGenderMale.isSelected = false
        btnGenderFemale.isSelected = false
        
        if (sender as! UIButton) == btnGenderMale {
            btnGenderMale.isSelected = true
        }
        else {
            btnGenderFemale.isSelected = true
        }
    }
    
    //MARK: - All Defined Functions
    
//    //=========================
//    func callsendImageAPI(){
//
//        //Set Your URL
//        let api_url = Constant.Update_User_URl
//            guard let url = URL(string: api_url) else {
//                return
//            }
//
//            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
//            urlRequest.httpMethod = "POST"
//            urlRequest.addValue("multipart/form-data; boundary=", forHTTPHeaderField: "Content-Type")
//        urlRequest.addValue("Bearer " + (UserDefaults.standard.string(forKey: "token") ?? ""), forHTTPHeaderField: "Authorization")
//
//            //Set Your Parameter
//            let parameterDict = MakeUpdateAPIBody()
//
//            //Set Image Data
//            let imgData = self.imgProfilePicImage.image!.jpegData(compressionQuality: 0.5)!
//
//           // Now Execute
//            AF.upload(multipartFormData: { multiPart in
//                for (key, value) in parameterDict {
//                    if let temp = value as? String {
//                        multiPart.append(temp.data(using: .utf8)!, withName: key as! String)
//                    }
//                    if let temp = value as? Int {
//                        multiPart.append("\(temp)".data(using: .utf8)!, withName: key as! String)
//                    }
//                    if let temp = value as? NSArray {
//                        temp.forEach({ element in
//                            let keyObj = key as! String + "[]"
//                            if let string = element as? String {
//                                multiPart.append(string.data(using: .utf8)!, withName: keyObj)
//                            } else
//                                if let num = element as? Int {
//                                    let value = "\(num)"
//                                    multiPart.append(value.data(using: .utf8)!, withName: keyObj)
//                            }
//                        })
//                    }
//                }
//                multiPart.append(imgData, withName: "file", fileName: "file.png", mimeType: "image/png")
//            }, with: urlRequest)
//                .uploadProgress(queue: .main, closure: { progress in
//                    //Current upload progress of file
//                    print("Upload Progress: \(progress.fractionCompleted)")
//                })
//                .responseJSON(completionHandler: { data in
//
//                           switch data.result {
//
//                           case .success(_):
//                            do {
//
//                            let dictionary = try JSONSerialization.jsonObject(with: data.data!, options: .fragmentsAllowed) as! NSDictionary
//
//                                print("Success!")
//                                print(dictionary)
//                           }
//                           catch {
//                              // catch error.
//                            print("catch error")
//
//                                  }
//                            break
//
//                           case .failure(_):
//                            print("failure")
//
//                            break
//
//                        }
//
//
//                })
//    }
//    //=========================
    
    func UpdateProfile(){
        CallUpdateDataAPI()
        dispatchGroup.leave()
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
    
    func CallUpdateDataAPI(){
//        callsendImageAPI()
        let APIBody = MakeUpdateAPIBody()
        print("\n===============")
        print("\nUpdate API Body\n",APIBody)

        loader.show(withStatus: "Please Wait While We are Getting Your Profile Data!")

        var request =  APIRequest(isLoader: true, method: .put, path: Constant.Update_User_URl, headers: HeaderValue.headerMultiPart.value, body: APIBody)

        getUpdateDataViewModel.CallToUpdateProfileData(request: request){ response in

            self.ProfileData = response
            DispatchQueue.main.async { [self] in
                //Execute UI Code on Completion of API Call and getting data
                UpdateProfileData()
                loader.dismiss()

            }
        } error: { error in
            print("========== Profile API Error :",error)
            self.loader.dismiss()
        }
    }
    
    func UpdateProfileData(){
        btnGenderMale.isSelected = false
        btnGenderFemale.isSelected = false
        var Date = ProfileData.data?.dob ?? ""
        Date = "\(Date.prefix(10))"
        CreateDatePicker(CurrentDOB: Date)
        
        imgProfilePicImage.SetImageWithKingFisher(ImageUrl: ProfileData.data?.profilePic ?? "", imageView: imgProfilePicImage)
        TfFirstName.text = ProfileData.data?.firstName
        TfLastName.text = ProfileData.data?.lastName
        TfPhoneNumber.text = "\(ProfileData.data?.phone ?? 0)"
        TfDOB.text = "\(Date)"
        
        
        
        if (ProfileData.data?.gender == "male") {
            btnGenderMale.isSelected = true
        }
        else{
            btnGenderFemale.isSelected = true
        }
        
    }
    
    func MakeUpdateAPIBody() -> [String : Any]{
        
        var SelectedGender = ""
        if btnGenderMale.isSelected{
            SelectedGender = "male"
        }
        else if btnGenderFemale.isSelected{
            SelectedGender = "female"
        }
        else{
            SelectedGender = ""
        }
        
        var Dict : [String : Any] = ["firstName": TfFirstName.text ?? "" , "lastName" : TfLastName.text ?? "", "gender" : SelectedGender , "dob" : TfDOB.text ?? "" , "phone" : TfPhoneNumber.text ?? ""]
        
        Dict = Dict.filter{$0.1 as! String != ""}
        
        return Dict
    }
    
    func SetUI(){
        loader.setDefaultMaskType(.black)
        imgProfilePicImage.layer.cornerRadius = imgProfilePicImage.frame.width/2
        imgProfilePicImage.layer.borderWidth = 4
        imgProfilePicImage.layer.borderColor = UIColor.black.cgColor
        SetImageRoundBorder(ImageView: imgProfilePicImage)
    }
    
    func OpenImagePicker(){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func CreateDatePicker(CurrentDOB : String){
        let datePicker = UIDatePicker()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd"
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .inline
        datePicker.maximumDate = Date()
        datePicker.backgroundColor = UIColor.white
        datePicker.date = dateFormatter.date(from: CurrentDOB) ?? Date()
        TfDOB.inputView = datePicker
        TfDOB.inputAccessoryView = createToolbar()
        //        TfBirthday.text = formatDate(date: Date()) // todays Date
    }
    
    func formatDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    func createToolbar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let Donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(DonePressed))
        toolbar.setItems([Donebtn], animated: true)
        
        return toolbar
    }
    
    func SetupRadioButton(){
        //Radio Button Image While Button is not Selected
        btnGenderMale.setImage(UIImage(named: "radio-button-notSelected"), for: .normal)
        btnGenderFemale.setImage(UIImage(named: "radio-button-notSelected"), for: .normal)
        
        //Radio Button Image While Button is Selected
        btnGenderMale.setImage(UIImage(named: "radio-button-selected"), for: .selected)
        btnGenderFemale.setImage(UIImage(named: "radio-button-selected"), for: .selected)
        
        btnGenderMale.tintColor = .clear
        btnGenderFemale.tintColor = .clear
        
    }
    
    //MARK: - All Objc Functions
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        //        print(keyboardSize.height)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    @objc func dateChange(datePicker: UIDatePicker)
    {
        TfDOB.text = formatDate(date: datePicker.date)
    }
    
    @objc func DonePressed(){
        self.view.endEditing(true)
    }
    
    @objc func TappedOnImage(_ sender:AnyObject){
        OpenImagePicker()
    }
}

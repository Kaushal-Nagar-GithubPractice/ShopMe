//
//  ProfileScreenVC.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit
import SVProgressHUD

protocol ChangeToHomeScreen{
    func ChangeToHomeScreen(tabbarItemIndex : Int)
}

class ProfileScreenVC: UIViewController {
    
    var getProfileDataViewModel = GetProfileDataViewModel()
    var ProfileData : Profile_Struct!
    let loader = SVProgressHUD.self
    
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var VwProfileMenuBgview: UIView!
    
    static var Delegate : ChangeToHomeScreen!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        loader.setDefaultMaskType(.black)
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = true
        
        if !UserDefaults.standard.bool(forKey: "IsRedirect"){
            
            imgProfileImage.image = UIImage(systemName: "person.circle.fill")
            lblUserName.text = "Guest"
            LoginAlert()
            
        }
        else{
            CallProfileDataAPI()
//            SetUI()
        }
    }
    
    //MARK: - All IBAction
    
    
    @IBAction func OnClickOpenWishlist(_ sender: Any) {
        
        let WishlistScreen = UIStoryboard(name: "WishList", bundle: nibBundle).instantiateViewController(withIdentifier: "WishListVC") as! WishListVC
        
        self.navigationController?.pushViewController(WishlistScreen, animated: true)
        
    }
    
    @IBAction func OnClickEditProfile(_ sender: Any) {
        let EditProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        EditProfileScreen.SelectedImage = imgProfileImage.image
        self.navigationController?.pushViewController(EditProfileScreen, animated: true)
    }
    
    @IBAction func OnClickLogout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "IsRedirect")
        UserDefaults.standard.set("", forKey: "token")
        ProfileScreenVC.Delegate.ChangeToHomeScreen(tabbarItemIndex : 0)
    }
    
    @IBAction func OnClickOpenMyOrder(_ sender: Any) {
        let myOrderScreen = self.storyboard?.instantiateViewController(withIdentifier: "MyOrderScreenVC") as! MyOrderScreenVC
        
        self.navigationController?.pushViewController(myOrderScreen, animated: true)
    }
    
    @IBAction func OnClickChangePassword(_ sender: Any) {
        
        let ChangePasswordScreen = UIStoryboard(name: "Authentication", bundle: nibBundle).instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        
        self.navigationController?.pushViewController(ChangePasswordScreen, animated: true)
        
    }
    
    
    //MARK: - All Defined Functions
    
    func SetUI(){
        
        imgProfileImage.SetImageWithKingFisher(ImageUrl: ProfileData.data?.profilePic ?? "", imageView: imgProfileImage)
        lblUserName.text = (ProfileData.data?.firstName ?? "") + " " + (ProfileData.data?.lastName ?? "")
        
        btnLogout.layer.cornerRadius = 10
//        imgProfileImage.image = UIImage(named: "Profile Pic")
//        lblUserName.text = UserDefaults.standard.string(forKey: "Username")
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = true
        
        VwProfileMenuBgview.layer.cornerRadius = 20
        VwProfileMenuBgview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        imgProfileImage.layer.cornerRadius = imgProfileImage.frame.width/2
        imgProfileImage.layer.borderWidth = 4
        imgProfileImage.layer.borderColor = UIColor.black.cgColor
        
        SetImageRoundBorder(ImageView: imgProfileImage)
        
    }
    
    func LoginAlert(){
        let alert = UIAlertController(title: "To Open Profile, \nYou Must be Logged in!", message: "" , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Login", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            self.NavigateToLoginVC()
        } ))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            ProfileScreenVC.Delegate.ChangeToHomeScreen(tabbarItemIndex : 0)
        } ))
//            alert.view..backgroundColor = UIColor(named: "Custom Black")
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.systemBackground
        alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderWidth = 0.5
        alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderColor = UIColor(named: "Custom Black")?.cgColor
        self.present(alert, animated: true, completion: nil)
    }
    
    func NavigateToLoginVC(){
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nibBundle)
        
        let loginVc = storyBoard.instantiateViewController(withIdentifier: "LoginScreenVC") as! LoginScreenVC
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
    
    func CallProfileDataAPI(){
        loader.show()
        
        imgProfileImage.image = UIImage(named: "")
            var request =  APIRequest(isLoader: true, method: .get, path: Constant.Get_User_URl, headers: HeaderValue.headerWithToken.value, body: nil)
            
            getProfileDataViewModel.CallToGetProfileData(request: request) { response in
                
                self.ProfileData = response
                DispatchQueue.main.async { [self] in
                    //Execute UI Code on Completion of API Call and getting data
                    SetUI()
                    loader.dismiss()
                }
            } error: { error in
                print("========== Profile API Error :",error)
                self.loader.dismiss()
            }
    }
}

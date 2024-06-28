//
//  ProfileScreenVC.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit

protocol ChangeToHomeScreen{
    func ChangeToHomeScreen(tabbarItemIndex : Int)
}

class ProfileScreenVC: UIViewController {
    
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
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = true
        
        if !UserDefaults.standard.bool(forKey: "IsRedirect"){
            
            imgProfileImage.image = UIImage(systemName: "person.circle.fill")
            lblUserName.text = "Guest"
            
            let alert = UIAlertController(title: "To Checkout You Must be Logged in!", message: "" , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Login", style: UIAlertAction.Style.default, handler: { (action) -> Void in
                self.NavigateToLoginVC()
            } ))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { (action) -> Void in
                ProfileScreenVC.Delegate.ChangeToHomeScreen(tabbarItemIndex : 0)
            } ))
            alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
            self.present(alert, animated: true, completion: nil)
        }
        else{
            SetUI()
        }
    }
    
    //MARK: - All IBAction
    
    @IBAction func OnClickEditProfile(_ sender: Any) {
        let EditProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        
        self.navigationController?.pushViewController(EditProfileScreen, animated: true)
    }
    
    @IBAction func OnClickLogout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "IsRedirect")
        
        ProfileScreenVC.Delegate.ChangeToHomeScreen(tabbarItemIndex : 0)
    }
    
    @IBAction func OnClickOpenMyOrder(_ sender: Any) {
        let myOrderScreen = self.storyboard?.instantiateViewController(withIdentifier: "MyOrderScreenVC") as! MyOrderScreenVC
        
        self.navigationController?.pushViewController(myOrderScreen, animated: true)
    }
    
    
    @IBAction func OnClickOpenShippingAddress(_ sender: Any) {
        
        let ShippingAddressScreen = UIStoryboard(name: "CartList", bundle: nibBundle).instantiateViewController(withIdentifier: "SelectAddressViewController") as! SelectAddressViewController
        
        self.navigationController?.pushViewController(ShippingAddressScreen, animated: true)
        
    }
    
    
    //MARK: - All Defined Functions
    
    func SetUI(){
        btnLogout.layer.cornerRadius = 10
        imgProfileImage.image = UIImage(named: "Profile Pic")
        lblUserName.text = UserDefaults.standard.string(forKey: "Username")
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = true
        
        VwProfileMenuBgview.layer.cornerRadius = 20
        VwProfileMenuBgview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        imgProfileImage.layer.cornerRadius = imgProfileImage.frame.width/2
        imgProfileImage.layer.borderWidth = 4
        imgProfileImage.layer.borderColor = UIColor.black.cgColor
        
        let borderLayer = CALayer()
        borderLayer.frame = imgProfileImage.bounds
        borderLayer.borderColor = UIColor.white.cgColor
        borderLayer.borderWidth = 8
        borderLayer.cornerRadius = borderLayer.frame.width / 2
        imgProfileImage.layer.insertSublayer(borderLayer, above: imgProfileImage.layer)
        
    }
    
    func NavigateToLoginVC(){
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nibBundle)
        
        let loginVc = storyBoard.instantiateViewController(withIdentifier: "LoginScreenVC") as! LoginScreenVC
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
}

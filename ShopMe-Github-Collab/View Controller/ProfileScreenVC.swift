//
//  ProfileScreenVC.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit

class ProfileScreenVC: UIViewController {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var VwProfileMenuBgview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        SetUI()
        self.navigationController?.isNavigationBarHidden = true
        lblUserName.text = UserDefaults.standard.string(forKey: "Username")
    }
    
    //MARK: - All IBAction
    
    @IBAction func OnClickEditProfile(_ sender: Any) {
        let EditProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        
        self.navigationController?.pushViewController(EditProfileScreen, animated: true)
    }
    
    @IBAction func OnClickLogout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "IsRedirect")
        self.tabBarController?.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func OnClickOpenMyOrder(_ sender: Any) {
        let myOrderScreen = self.storyboard?.instantiateViewController(withIdentifier: "MyOrderScreenVC") as! MyOrderScreenVC
        
        self.navigationController?.pushViewController(myOrderScreen, animated: true)
    }
    
    //MARK: - All Defined Functions
    
    func SetUI(){
        self.tabBarController?.tabBar.isHidden = false
        
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
  
}

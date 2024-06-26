//
//  CustomTabbarController.swift
//  IOS_Collob
//
//  Created by Webcodegenie on 20/06/24.
//

import UIKit

class CustomTabbarController: UITabBarController {
    
    var controller4 = UIViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabbarItemsController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        
    }
    
    
    // MARK: - Actions
    
    
    func setTabbarItemsController(){
        let controller1 = UIViewController()
        //        let controller1 = UIStoryboard(name: "HomeStoryboard", bundle: nibBundle).instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        controller1.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home"), tag: 1)
        let nav1 = UINavigationController(rootViewController: controller1)
        
        
        let controller2 = UIViewController()
        //        let controller1 = UIStoryboard(name: "HomeStoryboard", bundle: nibBundle).instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        controller2.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Shop"), tag: 2)
        let nav2 = UINavigationController(rootViewController: controller2)
        
//        let controller3 = UIViewController()
        let controller3 = UIStoryboard(name: "CartList", bundle: nibBundle).instantiateViewController(identifier: "ShoppingCartViewController") as! ShoppingCartViewController
        controller3.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Cart"), tag: 3)
        let nav3 = UINavigationController(rootViewController: controller3)
        
        
        
        if UserDefaults.standard.bool(forKey: "IsRedirect"){
            controller4 = UIStoryboard(name: "Profile", bundle: nibBundle).instantiateViewController(identifier: "ProfileScreenVC") as! ProfileScreenVC
        }
        else{
            controller4 = UIStoryboard(name: "Authentication", bundle: nibBundle).instantiateViewController(identifier: "LoginScreenVC") as! LoginScreenVC
        }
        
        controller4.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Profile"), tag: 4)
        let nav4 = UINavigationController(rootViewController: controller4)
        
        setViewControllers([nav1, nav2,  nav3, nav4], animated: true)
    }
    
}

//
//  CustomTabbarController.swift
//  IOS_Collob
//
//  Created by Webcodegenie on 20/06/24.
//

import UIKit


class CustomTabbarController: UITabBarController, ChangeToHomeScreen {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileScreenVC.Delegate = self
        setTabbarItemsController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    // MARK: - Actions
    
    
    func setTabbarItemsController(){
//        let controller1 = UIViewController()
                let controller1 = UIStoryboard(name: "HomeStoryboard", bundle: nibBundle).instantiateViewController(identifier: "HomeVC") as! HomeVC
        controller1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "tab1"), tag: 1)
        let nav1 = UINavigationController(rootViewController: controller1)
        
        
//        let controller2 = UIViewController()
                let controller2 = UIStoryboard(name: "ShopStoryboard", bundle: nibBundle).instantiateViewController(identifier: "ShopVC") as! ShopVC
        controller2.tabBarItem = UITabBarItem(title: "Shop", image: UIImage(named: "tab2"), tag: 2)
        let nav2 = UINavigationController(rootViewController: controller2)
        

//        let controller3 = UIViewController()
                    let controller3 = UIStoryboard(name: "CartList", bundle: nibBundle).instantiateViewController(identifier: "ShoppingCartViewController") as! ShoppingCartViewController
        controller3.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "tab3"), tag: 3)
        let nav3 = UINavigationController(rootViewController: controller3)
        
        
        //        let controller4 = UIViewController()
        let controller4 = UIStoryboard(name: "Profile", bundle: nibBundle).instantiateViewController(identifier: "ProfileScreenVC") as! ProfileScreenVC
        controller4.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "tab4"), tag: 4)

        let nav4 = UINavigationController(rootViewController: controller4)
        
        setViewControllers([nav1, nav2,  nav3, nav4], animated: true)
    }
    
    
    func ChangeToHomeScreen() {
        selectedIndex = 0
    }
    
}

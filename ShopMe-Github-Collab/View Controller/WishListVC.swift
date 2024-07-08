//
//  WishListVC.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 05/07/24.
//

import UIKit
import SVProgressHUD

class WishListVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
    var ShopProducts = [wishlist_Products]()
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var collectionWishList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionWishList.dataSource = self
        collectionWishList.delegate = self
    }

    
    //MARK: APPLICATION DELEGATE METHODS
   
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.setDefaultMaskType(.black)
        
        self.tabBarController?.tabBar.isHidden = false
        self.collectionWishList.showsVerticalScrollIndicator = false

//        setUpMenuButton(isScroll: true)
//        collectionWishList.reloadData()

        callWishlistAPI(url: Constant.wishlistGet)

        
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            self.collectionWishList?.reloadData()
        }
    }

    //MARK: COLLECTIONVIEW DELEGATE METHODS
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return ShopProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = ShopProducts[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wishListCVCell", for: indexPath) as! wishListCVCell
        cell.imgProduct.setImage(imgUrl: product.images?.first ?? "" , imgView: cell.imgProduct)
        cell.lblProductName.text =  product.productName
        cell.lblPrice.text =  "$ \(product.price ?? 123)"
        cell.lblStrikePrice.isHidden = true
        
        
        print("====>.....pname---",product.productName)
       
        return cell
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "DetailsScreenVC") as! DetailsScreenVC
//            vc.productID = ShopProducts[indexPath.row]._id ?? ""
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 5, height: 285)
    }
    

    //MARK: USERDEFINED  METHODS
    
//    func setUpMenuButton(isScroll : Bool){
//
//        let icon = UIImage(named: "setting")
//        let iconSize = CGRect(origin: CGPoint.init(x: 10, y: 0), size: CGSize(width: 20, height: 18))
//        let iconButton = UIButton(frame: iconSize)
//        iconButton.tintColor = UIColor(named: "Custom Black")
//        iconButton.setBackgroundImage(icon, for: .normal)
//        let barButton = UIBarButtonItem(customView: iconButton)
//        iconButton.addTarget(self, action: #selector(btnBackClicked), for: .touchUpInside)
//        navigationItem.rightBarButtonItem = barButton
//        self.navigationItem.title = "Shop"
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)]
//        navigationController?.navigationBar.prefersLargeTitles = false
//    }
    
    
    func callWishlistAPI(url : String){
        
        SVProgressHUD.show()
        let request  = APIRequest(isLoader: true, method: HTTPMethods.get, path: url, headers: HeaderValue.headerWithToken.value, body: nil)
        
        WishlistViewModel().getWishlistData(request: request) { response in
            print("====> api respp ===>",response)
            
            if response.success == true {
                DispatchQueue.main.async {
                    self.ShopProducts = response.data?.products ?? []
                    self.collectionWishList.reloadData()
                    SVProgressHUD.dismiss()
                }
            }else{
                print("resposne failed in wishlist=====>")
            }
        } error: { error in
            print("===>Api error ===>", error)
        }

    }


}

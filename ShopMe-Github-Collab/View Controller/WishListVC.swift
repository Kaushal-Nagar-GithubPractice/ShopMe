//
//  WishListVC.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 05/07/24.
//

import UIKit
import SVProgressHUD


class WishListVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ReloadCollectionView {
    
    var ShopProducts = [wishlist_Products]()
    var wishlistViewModel = WishlistViewModel()
    
    @IBOutlet weak var VwEmptyOrderView: UIView!
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var collectionWishList: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionWishList.dataSource = self
        collectionWishList.delegate = self
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        SetUI()
//        setUpMenuButton(isScroll: true)
//        collectionWishList.reloadData()

        callWishlistAPI(url: Constant.Get_Wishlist_URL)

    }
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            self.collectionWishList?.reloadData()
        }
    }


    //MARK: ALL IBACTIONS
    
    
    @IBAction func OnClickCloseWishlist(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: COLLECTIONVIEW DELEGATE METHODS
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return ShopProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = ShopProducts[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wishListCVCell", for: indexPath) as! wishListCVCell

        
        cell.imgProduct.SetImageWithKingFisher(ImageUrl: product.images?.first ?? "", imageView: cell.imgProduct)
        cell.lblProductName.text =  product.productName
        cell.lblPrice.text =  "₹ \(product.price ?? 123)"
        cell.lblStrikePrice.isHidden = true
        cell.btnWishList.tintColor = .systemRed
        cell.btnWishList.tag = indexPath.item
        cell.WishlistProducts = ShopProducts
        cell.delegate = self

        
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
    

    func SetUI(){
        self.tabBarController?.tabBar.isHidden = false
        SVProgressHUD.setDefaultMaskType(.black)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func UpdateUIData(){
        self.collectionWishList.reloadData()
        
        if ShopProducts.count == 0{
            VwEmptyOrderView.isHidden = false
            collectionWishList.isHidden = true
        }
        else{
            VwEmptyOrderView.isHidden = true
            collectionWishList.isHidden = false
        }
    }

    
    func callWishlistAPI(url : String){
        
        SVProgressHUD.show()

        
        let request  = APIRequest(isLoader: true, method: .get, path: url, headers: HeaderValue.headerWithToken.value, body: nil)
        
        wishlistViewModel.getWishlistData(request: request) { response in
            print("====> api respp ===>",response)
            
            if response.success == true {
                self.ShopProducts = response.data?.products ?? []
                DispatchQueue.main.async {
                    self.UpdateUIData()

                    SVProgressHUD.dismiss()
                }
            }else{
                print("resposne failed in wishlist=====>")
            }

            SVProgressHUD.dismiss()
        } error: { error in
            print("===>Api error ===>", error)
            SVProgressHUD.dismiss()
        }

    }
    
    func ReloadCollectionView() {
        callWishlistAPI(url: Constant.Get_Wishlist_URL)
    }


}

//
//  HomeVC.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit
import Kingfisher
import SVProgressHUD
class HomeVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, ProductSelect, UICollectionViewDelegateFlowLayout {
    func reloadAfterWishlist() {
        callApiProduct()
        
    }
    
    var isFirstTimeApiCall = true
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var arrHeaderImages = ["carousel-1","carousel-2","carousel-3"]
    var arrHeaderLabel = ["Men Fashion","Women Fashion","Kids Fashion"]
    var arrQualityImages = ["checkmark","truck.box.fill","shippingbox","phone"]
    var arrQualityText = ["  Quality Product","  Free Shipping","  14-Day Return","  24/7 Support"]
    var pageCount = 1
    var ArrCategory = [Categories_Data]()
    var ArrProducts = [Products]()
    var arrBannerCategory = [Categories_Data]()
    var flagForEmptyProdCall = true
    @IBOutlet weak var collectionCategories: UICollectionView!
    @IBOutlet weak var collecctionFacilities: UICollectionView!
    @IBOutlet weak var pageControlHeader: UIPageControl!
    @IBOutlet weak var collectionHeader: UICollectionView!
    @IBOutlet weak var tblViewHomeScreen: UITableView!
    var timer : Timer?
    var currentCellIndex = 0
    var TableHeight = CGFloat(0)
    //MARK: Application Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewHomeScreen.delegate = self
        tblViewHomeScreen.dataSource = self
        collectionHeader.delegate = self
        collectionHeader.dataSource = self
        collectionCategories.delegate = self
        collectionCategories.dataSource = self
        collecctionFacilities.delegate = self
        collecctionFacilities.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        SVProgressHUD.setDefaultMaskType(.black)
//        SVProgressHUD.show()
        timer?.invalidate()
        currentCellIndex = 0
        self.tblViewHomeScreen.showsVerticalScrollIndicator = false
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        collectionHeader.showsHorizontalScrollIndicator = false
        collectionCategories.showsHorizontalScrollIndicator = false
        collecctionFacilities.showsHorizontalScrollIndicator = false
        pageControlHeader.numberOfPages = arrBannerCategory.count
        collectionHeader.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
        pageControlHeader.currentPage = 0
//        pageCount = 1
//        flagForEmptyProdCall = true
//        ArrProducts = []
        if isFirstTimeApiCall {
            self.callApiCategory()
            self.callApiProduct()
        }
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) {_ in
            self.tblViewHomeScreen.reloadData()
            self.collectionHeader.reloadData()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) {_ in
            self.tblViewHomeScreen.reloadData()
            self.collectionHeader.reloadData()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        
    }
    //MARK: IBAction Methods
    
    //MARK: Collection Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            if (arrBannerCategory.count) > 1 {
                return (arrBannerCategory.count) * 1000
            }else{return 1}
        }
        else if collectionView.tag == 2 {
            return arrQualityImages.count
        }
        else if collectionView.tag == 3 {
//            print(ArrCategory.count)
            return ArrCategory.count
        }else{
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHeaderCollectionViewCell", for: indexPath) as! HomeHeaderCollectionViewCell
            if (arrBannerCategory.count != 0){
                if arrBannerCategory.count != 1 {
                    cell.imageHeader.setImageWithURL(url: arrBannerCategory[indexPath.row % (arrBannerCategory.count )].bannerImage ?? "", imageView: cell.imageHeader)
                    cell.lblHeader.text = arrBannerCategory[indexPath.row % (arrBannerCategory.count )].categoryName
                    cell.lblDetailHeader.text = arrBannerCategory[indexPath.row % (arrBannerCategory.count)].description
                }
                else{
                    collectionView.isScrollEnabled = false
                    timer?.invalidate()
                    cell.imageHeader.setImageWithURL(url: arrBannerCategory[indexPath.row].bannerImage ?? "", imageView: cell.imageHeader)
                    cell.lblHeader.text = arrBannerCategory[indexPath.row].categoryName
                    cell.lblDetailHeader.text = arrBannerCategory[indexPath.row].description
                }
            }
            else{
                cell.imageHeader.image = UIImage(named: "placeholder")
                cell.lblHeader.text = ""
                cell.lblDetailHeader.text = ""
                timer?.invalidate()
                collectionView.isScrollEnabled = false
            }
           
            return cell
        }
        else if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeFacilitesCollectionViewCell", for: indexPath) as! HomeFacilitesCollectionViewCell
            cell.imageFacilites.image = UIImage(systemName: arrQualityImages[indexPath.row] )
            cell.lblFacilites.text = arrQualityText[indexPath.row]
            return cell
        }
        else  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            cell.imageCategories.setImageWithURL(url: ArrCategory[indexPath.row].image ?? "" , imageView: cell.imageCategories)
            cell.lblCategoryName.text = ArrCategory[indexPath.row].categoryName
            cell.lblCategoryQuantity.text = "\(ArrCategory[indexPath.row].productCount ?? 0) products "
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionCategories {
            return CGSize(width: 225, height: 100)
        }
        return CGSize(width: collectionHeader.frame.width , height: 225)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        if scrollView == collectionHeader{
        //            guard let visiblecell = collectionHeader.visibleCells.first else { return  }
        //            let indexpath = collectionHeader.indexPath(for: visiblecell)
        //            currentCellIndex = indexpath?.row ?? 0
        //            print(indexpath?.row)Œ
        //            pageControlHeader.currentPage = currentCellIndex % arrHeaderImages.count
        //        }
        
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionHeader{
            guard let visiblecell = collectionHeader.visibleCells.last else { return  }
            let indexpath = collectionHeader.indexPath(for: visiblecell)
            currentCellIndex = indexpath?.row ?? 0
            pageControlHeader.currentPage = currentCellIndex % (arrBannerCategory.count)
        }
        collectionHeader.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    
    if scrollView == tblViewHomeScreen {
        if scrollView.contentOffset.y + self.view.frame.height - 200 >= tblViewHomeScreen.contentSize.height {
            if flagForEmptyProdCall {
                pageCount += 1
                callApiProduct()
            }
        }
    }
}
    //MARK: TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.arrProducts = ArrProducts
        cell.collectionProducts.reloadData()
        cell.frame = tableView.bounds
        cell.layoutIfNeeded()
        cell.HeightConstraint.constant = cell.collectionProducts.collectionViewLayout.collectionViewContentSize.height
        cell.delegate = self
        
      
        return cell
    }
    //MARK: User Defined Methods
    
    func callApiCategory(){
                SVProgressHUD.setDefaultMaskType(.black)
                SVProgressHUD.show()
        let request = APIRequest(isLoader: true, method: HTTPMethods.get, path: Constant.GET_CATEGORY_LIST, headers: HeaderValue.headerWithoutAuthToken.value, body: nil)
     
        CategoryViewModal.ApiCategory.getCategoryData(request: request) { response in
            DispatchQueue.main.async {
                
                if response.data?.categories?.count == 0{
                    print(response.status as Any,response.message as Any)
                }else{
                    self.ArrCategory = response.data?.categories ?? []
//                    print(self.ArrCategory)
                    self.findBannerCategories()
                    self.collectionHeader.reloadData()
                    self.collectionCategories.reloadData()
                    SVProgressHUD.dismiss()
                }
            }
        } error: { error in
            print(error as Any)
            SVProgressHUD.dismiss()
        }
    }
    func callApiProduct(){
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        let request = APIRequest(isLoader: true, method: HTTPMethods.get, path: Constant.GET_PRODUCT_LIST+"?page=\(pageCount)&items=6", headers: HeaderValue.headerWithoutAuthToken.value, body: nil)
//        print("----------------------",Constant.GET_PRODUCT_LIST+"?page=\(pageCount)&items=6")
        ProductViewModel.ApiProduct.getProductData(request: request) { response in
            DispatchQueue.main.async {
                if response.data?.products?.isEmpty == true{
                    print(response.status as Any,response.message as Any)
                    self.flagForEmptyProdCall = false
                    SVProgressHUD.dismiss()
                }
                else{
                    self.ArrProducts.append(contentsOf: response.data?.products ?? [])
                    print(self.ArrProducts.count as Any)
                    self.tblViewHomeScreen.reloadData()
                    SVProgressHUD.dismiss()
                    self.isFirstTimeApiCall = false
                }
            }
        } error: { error in
            print(error as Any)
            SVProgressHUD.dismiss()
        }
    }
    
    func findBannerCategories(){
        arrBannerCategory = []
        for i in 0..<(ArrCategory.count) {
            if ArrCategory[i].banner == true {
                arrBannerCategory.append(ArrCategory[i] )
            }
        }
        print(arrBannerCategory)
        pageControlHeader.numberOfPages = arrBannerCategory.count
    }
    
    //MARK: @OBJC Methods
    
    @objc func slideToNext(){
        
        currentCellIndex = currentCellIndex + 1
        if arrBannerCategory.count > 1 {
//            print(currentCellIndex)
            pageControlHeader.currentPage = currentCellIndex % (arrBannerCategory.count )
            collectionHeader.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
        }
    }
    
    
    //MARK: Protocol Defined Methods
    func selectedProduct(productId : String) {
        let vc = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "DetailsScreenVC") as! DetailsScreenVC
        vc.productID = productId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


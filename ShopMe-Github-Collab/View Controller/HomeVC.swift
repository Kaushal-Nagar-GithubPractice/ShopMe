//
//  HomeVC.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, ProductSelect, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var frame = CGFloat(0)
    var arrHeaderImages = ["carousel-1","carousel-2","carousel-3"]
    var arrHeaderLabel = ["Men Fashion","Women Fashion","Kids Fashion"]
    var arrQualityImages = ["checkmark","truck.box.fill","shippingbox","phone"]
    var arrQualityText = ["  Quality Product","  Free Shipping","  14-Day Return","  24/7 Support"]
    var arrCategoryImage = ["cat-1","cat-2","cat-3","cat-4","cat-1","cat-2","cat-3","cat-4"]
    
    @IBOutlet weak var collectionCategories: UICollectionView!
    @IBOutlet weak var collecctionFacilities: UICollectionView!
    @IBOutlet weak var pageControlHeader: UIPageControl!
    @IBOutlet weak var collectionHeader: UICollectionView!
    @IBOutlet weak var tblViewHomeScreen: UITableView!
    var timer : Timer?
    var currentCellIndex = 0
    var TableHeight = CGFloat(0)
    var cartItemArray : Array<Dictionary<String, String>> = []
    var MyOrders : Array<Dictionary<String, String>> = [["Date":"24 June 2024", "TotalItem":"5", "TotalAmount":"5000.00","Status":"Placed"],
                                                        ["Date":"20 May 2024", "TotalItem":"2", "TotalAmount":"200.00","Status":"Cancelled"],
    ]
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
        
        if !UserDefaults.standard.bool(forKey: "MyOrderSet"){
            UserDefaults.standard.set(MyOrders, forKey: "MyOrder")
            
        }
        UserDefaults.standard.set(true, forKey: "MyOrderSet")
        UserDefaults.standard.set(cartItemArray, forKey: "MyCart")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        timer?.invalidate()
        currentCellIndex = 0
        self.tblViewHomeScreen.showsVerticalScrollIndicator = false
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        collectionHeader.showsHorizontalScrollIndicator = false
        collectionCategories.showsHorizontalScrollIndicator = false
        collecctionFacilities.showsHorizontalScrollIndicator = false
        pageControlHeader.numberOfPages = arrHeaderImages.count
        collectionHeader.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
        pageControlHeader.currentPage = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            self.tblViewHomeScreen.reloadData()
        }
  
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
               
    }
    //MARK: IBAction Methods
    
    //MARK: Collection Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return arrHeaderImages.count * 1000
        }
        else if collectionView.tag == 2 {
            return arrQualityImages.count
        }
        else if collectionView.tag == 3 {
            return arrCategoryImage.count
        }else{
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHeaderCollectionViewCell", for: indexPath) as! HomeHeaderCollectionViewCell
            cell.imageHeader.image = UIImage(named: arrHeaderImages[indexPath.row % arrHeaderImages.count])
            cell.lblHeader.text = arrHeaderLabel[indexPath.row % arrHeaderImages.count]
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
            cell.imageCategories.image = UIImage(named: arrCategoryImage[indexPath.row])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionHeader.frame.width , height: 225)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == collectionHeader{
//            guard let visiblecell = collectionHeader.visibleCells.first else { return  }
//            let indexpath = collectionHeader.indexPath(for: visiblecell)
//            currentCellIndex = indexpath?.row ?? 0
//            print(indexpath?.row)
//            pageControlHeader.currentPage = currentCellIndex % arrHeaderImages.count
//        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionHeader{
            guard let visiblecell = collectionHeader.visibleCells.last else { return  }
            let indexpath = collectionHeader.indexPath(for: visiblecell)
            currentCellIndex = indexpath?.row ?? 0
            pageControlHeader.currentPage = currentCellIndex % arrHeaderImages.count
        }
        collectionHeader.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }
    
    
    
    //MARK: TableView Delegate Methods
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.frame = tableView.bounds
        
        cell.layoutIfNeeded()
        
        cell.collectionProducts.reloadData()
        
        cell.HeightConstraint.constant = cell.collectionProducts.collectionViewLayout.collectionViewContentSize.height
        cell.delegate = self
        return cell
    }
    //MARK: User Defined Methods
    
    
    
    //MARK: @OBJC Methods
    
    @objc func slideToNext(){
        
        currentCellIndex = currentCellIndex + 1
        pageControlHeader.currentPage = currentCellIndex % arrHeaderImages.count
        collectionHeader.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
        print(currentCellIndex)
    }
    
    
    //MARK: Protocol Defined Methods
    func selectedProduct(imageName : String,ProductName : String, Price : Double) {
        let vc = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "DetailsScreenVC") as! DetailsScreenVC
        vc.arrCategoryImage.insert(imageName, at: 0)
        vc.Price = "\(Price)"
        vc.ProductName = "\(ProductName)"
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
}

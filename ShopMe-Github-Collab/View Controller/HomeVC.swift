//
//  HomeVC.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, ProductSelect {
  
    

    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var frame = CGFloat(0)
    var arrHeaderImages = ["carousel-1","carousel-2","carousel-3"]
    var arrHeaderLabel = ["Men Fashion","Women Fashion","Kids Fashion"]
    var arrQualityImages = ["check-mark","truck","mobile-data","phone-ringing"]
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
        pageControlHeader.numberOfPages = arrHeaderImages.count
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        collectionHeader.showsHorizontalScrollIndicator = false
        collectionCategories.showsHorizontalScrollIndicator = false
        collecctionFacilities.showsHorizontalScrollIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    //MARK: IBAction Methods
    
    //MARK: Collection Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return arrHeaderImages.count
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
            cell.imageHeader.image = UIImage(named: arrHeaderImages[indexPath.row])
            cell.lblHeader.text = arrHeaderLabel[indexPath.row]
            return cell
        }
        else if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeFacilitesCollectionViewCell", for: indexPath) as! HomeFacilitesCollectionViewCell
            
            cell.imageFacilites.image = UIImage(named: arrQualityImages[indexPath.row])
            cell.lblFacilites.text = arrQualityText[indexPath.row]
            return cell
        }
        else  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            cell.imageCategories.image = UIImage(named: arrCategoryImage[indexPath.row])
            return cell
        }
        
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
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension

}
   
    //MARK: User Defined Methods
    
    
    
    //MARK: @OBJC Methods
    
    
    @objc func slideToNext(){
        if currentCellIndex < arrHeaderImages .count - 1{
            currentCellIndex = currentCellIndex + 1
        }
        else{
            currentCellIndex = 0
        }
        pageControlHeader.currentPage = currentCellIndex
        collectionHeader.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }
    
    
    //MARK: Protocol Defined Methods
    func selectedProduct(imageName : String) {
        let vc = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "DetailsScreenVC") as! DetailsScreenVC
        vc.arrCategoryImage.insert(imageName, at: 0)
        self.navigationController?.pushViewController(vc, animated: true)
    }
   

}

//
//  DetailsScreenVC.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit

class DetailsScreenVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    
    @IBOutlet weak var collectionSelectedItem: UICollectionView!
    
    @IBOutlet weak var collectionSuggestedProducts: UICollectionView!
    @IBOutlet weak var btnAddtoCart: UIButton!
    @IBOutlet weak var btnQuantityAdd: UIButton!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var btnQuantityMinus: UIButton!
    @IBOutlet weak var btnColorGreen: UIButton!
    @IBOutlet weak var btnColorBlue: UIButton!
    @IBOutlet weak var btnColorRed: UIButton!
    @IBOutlet weak var btnColorBlack: UIButton!
    @IBOutlet weak var btnColorWhite: UIButton!
    @IBOutlet weak var btnSizeXL: UIButton!
    @IBOutlet weak var btnSizeL: UIButton!
    @IBOutlet weak var btnSizeM: UIButton!
    @IBOutlet weak var btnSizeS: UIButton!
    @IBOutlet weak var btnSizeXS: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var arrCategoryImage =  ["product-1","product-2","product-3","product-4","product-5","product-6","product-7","product-8","product-9"]
    var timer : Timer?
    var currentCellIndex = 0
    var SelectecColor = ""
    var SelectedSize = ""
    var Quantity = 1
    
    
    //MARK: Application Delegate Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = arrCategoryImage.count
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        collectionSelectedItem.delegate = self
        collectionSelectedItem.dataSource = self
        collectionSuggestedProducts.delegate = self
        collectionSuggestedProducts.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        lblQuantity.text = "\(Quantity)"
        self.navigationController?.isNavigationBarHidden = false
        scrollView.showsVerticalScrollIndicator = false
        collectionSelectedItem.showsHorizontalScrollIndicator = false
        collectionSuggestedProducts.showsHorizontalScrollIndicator = false
        setUpMenuButton(isScroll: true)
        self.navigationItem.title = "Product Detail"
        navigationController?.navigationBar.barTintColor = UIColor.systemYellow
        
        btnSizeXL.layer.cornerRadius = 30
        btnSizeL.layer.cornerRadius = 30
        btnSizeM.layer.cornerRadius = 30
        btnSizeS.layer.cornerRadius = 30
        btnSizeXS.layer.cornerRadius = 30
        
        btnColorGreen.layer.cornerRadius = 30
        btnColorBlue.layer.cornerRadius = 30
        btnColorRed.layer.cornerRadius = 30
        btnColorBlack.layer.cornerRadius = 30
        btnColorWhite.layer.cornerRadius = 30
        
        btnSizeXL.layer.borderWidth = 2
        btnSizeXL.layer.borderColor = UIColor.black.cgColor
        btnSizeL.layer.borderWidth = 2
        btnSizeL.layer.borderColor = UIColor.black.cgColor
        btnSizeM.layer.borderWidth = 2
        btnSizeM.layer.borderColor = UIColor.black.cgColor
        btnSizeS.layer.borderWidth = 2
        btnSizeS.layer.borderColor = UIColor.black.cgColor
        btnSizeXS.layer.borderWidth = 2
        btnSizeXS.layer.borderColor = UIColor.black.cgColor
        
        btnColorGreen.layer.borderColor = UIColor.black.cgColor
        btnColorGreen.layer.borderWidth = 2
        btnColorBlue.layer.borderColor = UIColor.black.cgColor
        btnColorBlue.layer.borderWidth = 2
        btnColorRed.layer.borderColor = UIColor.black.cgColor
        btnColorRed.layer.borderWidth = 2
        btnColorBlack.layer.borderColor = UIColor.black.cgColor
        btnColorBlack.layer.borderWidth = 2
        btnColorWhite.layer.borderColor = UIColor.black.cgColor
        btnColorWhite.layer.borderWidth = 2
        
        
    }
    
    //MARK: IBACTION Method

    @IBAction func onCLickbtnSIze(_ sender: UIButton) {
        if sender.tag == 1{
            
            SelectedSize = "XS"
        }
        else if sender.tag == 2{
           
            SelectedSize = "S"
        }
        else if sender.tag == 3{
            
            SelectedSize = "M"
        }
        else if sender.tag == 4{
            
            SelectedSize = "L"
        }
        else if sender.tag == 5{
            
            SelectedSize = "XL"
        }
    }
    
    
    @IBAction func onClickBtnColor(_ sender: UIButton) {
        
        if sender.tag == 6{
            
            SelectecColor = "W"
        }
        else if sender.tag == 7{
            
            SelectecColor = "Bk"
        }
        else if sender.tag == 8{
            
            SelectecColor = "R"
        }
        else if sender.tag == 9{
            
            SelectecColor = "Bl"
        }
        else if sender.tag == 10{
            
            SelectecColor = "G"
        }
    }
    
    @IBAction func onClickPlus(_ sender: Any) {
        if Quantity >= 5 {
            
        }
        else{
           Quantity += 1
            lblQuantity.text = "\(Quantity)"
        }
    }
    @IBAction func onClickMinus(_ sender: Any) {
        if Quantity == 1 {
            
        }
        else{
           Quantity -= 1
            lblQuantity.text = "\(Quantity)"
        }
        
    }
    @IBAction func onCLickAddtoCart(_ sender: Any) {
    }
    
    //MARK: Delegate Method
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return arrCategoryImage.count * 1000
        }
        else{
            return arrCategoryImage.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHeaderCollectionViewCell", for: indexPath) as! HomeHeaderCollectionViewCell
            cell.imageHeader.image = UIImage(named: arrCategoryImage[indexPath.row % arrCategoryImage.count])
            cell.viewHeader.backgroundColor = .systemGray5
            cell.viewHeader.layer.cornerRadius = 25
            cell.viewHeader.layer.masksToBounds = true
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            cell.imageCategories.image = UIImage(named: arrCategoryImage[indexPath.row])
            cell.lblCategoryName.text = "Product Name"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            let vc = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "ImageDisplayViewController") as! ImageDisplayViewController
            vc.arrImageDisplay = arrCategoryImage
            vc.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(vc, animated: true)
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .fullScreen
            present(vc,animated: true)
        }
    }
    //MARK: User Defined Methods
    
    func setUpMenuButton(isScroll : Bool){
        
        let icon = UIImage(systemName: "chevron.left")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20))
        let iconButton = UIButton(frame: iconSize)
        iconButton.tintColor = isScroll ? .label : .label
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(btnBackClicked), for: .touchUpInside)
        navigationItem.leftBarButtonItem = barButton
       
    }
    
    //MARK: @OBJC Methods
    
    
    @objc func slideToNext(){
        currentCellIndex = currentCellIndex + 1
        pageControl.currentPage = currentCellIndex % arrCategoryImage.count
        collectionSelectedItem.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }
    
    @objc func btnBackClicked(){
        self.navigationController?.popViewController(animated: true)
    }
}
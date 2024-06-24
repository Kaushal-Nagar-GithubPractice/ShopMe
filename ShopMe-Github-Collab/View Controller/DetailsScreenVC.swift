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
    var arrCategoryImage = ["cat-1","cat-2","cat-3","cat-4","cat-1","cat-2","cat-3","cat-4"]
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
        navigationController?.title = "Product Detail"
    }
    
    //MARK: IBACTION Method

    @IBAction func onCLickbtnSIze(_ sender: UIButton) {
        if sender.tag == 1{
            btnSizeXS.setImage(UIImage(named: "accept"), for: .normal)
            btnSizeL.setImage(UIImage(named: "empty"), for: .normal)
            btnSizeS.setImage(UIImage(named: "empty"), for: .normal)
            btnSizeXL.setImage(UIImage(named: "empty"), for: .normal)
            btnSizeM.setImage(UIImage(named: "empty"), for: .normal)
            SelectedSize = "XS"
        }
        else if sender.tag == 2{
            btnSizeS.setImage(UIImage(named: "accept"), for: .normal)
            btnSizeL.setImage(UIImage(named: "empty"), for: .normal)
            btnSizeXS.setImage(UIImage(named: "empty"), for: .normal)
            btnSizeXL.setImage(UIImage(named: "empty"), for: .normal)
            btnSizeM.setImage(UIImage(named: "empty"), for: .normal)
            SelectedSize = "S"
        }
        else if sender.tag == 3{
            btnSizeM.setImage(UIImage(named: "accept"), for: .normal)
            btnSizeL.imageView?.image = UIImage(named: "empty")
            btnSizeS.imageView?.image = UIImage(named: "empty")
            btnSizeXL.imageView?.image = UIImage(named: "empty")
            btnSizeXS.imageView?.image = UIImage(named: "empty")
            SelectedSize = "M"
        }
        else if sender.tag == 4{
            btnSizeL.setImage(UIImage(named: "accept"), for: .normal)
            btnSizeXS.setImage(UIImage(named: "empty"), for: .normal)
            btnSizeS.setImage(UIImage(named: "empty"), for: .normal)
            btnSizeXL.setImage(UIImage(named: "empty"), for: .normal)
            btnSizeM.setImage(UIImage(named: "empty"), for: .normal)
            SelectedSize = "L"
        }
        else if sender.tag == 5{
            btnSizeXL.setImage(UIImage(named: "accept"), for: .normal)
            btnSizeL.setImage(UIImage(named: "empty"), for: .normal)
            btnSizeS.setImage(UIImage(named: "empty"), for: .normal)
            btnSizeXS.setImage(UIImage(named: "empty"), for: .normal)
            btnSizeM.setImage(UIImage(named: "empty"), for: .normal)
            SelectedSize = "XL"
        }
    }
    
    
    @IBAction func onClickBtnColor(_ sender: UIButton) {
        
        if sender.tag == 6{
            btnColorWhite.setImage(UIImage(named: "accept"), for: .normal)
            btnColorRed.setImage(UIImage(named: "empty"), for: .normal)
            btnColorBlue.setImage(UIImage(named: "empty"), for: .normal)
            btnColorGreen.setImage(UIImage(named: "empty"), for: .normal)
            btnColorBlack.setImage(UIImage(named: "empty"), for: .normal)
            SelectecColor = "W"
        }
        else if sender.tag == 7{
            btnColorBlack.setImage(UIImage(named: "accept"), for: .normal)
            btnColorRed.setImage(UIImage(named: "empty"), for: .normal)
            btnColorBlue.setImage(UIImage(named: "empty"), for: .normal)
            btnColorGreen.setImage(UIImage(named: "empty"), for: .normal)
            btnColorWhite.setImage(UIImage(named: "empty"), for: .normal)
            SelectecColor = "Bk"
        }
        else if sender.tag == 8{
            btnColorRed.setImage(UIImage(named: "accept"), for: .normal)
            btnColorBlack.setImage(UIImage(named: "empty"), for: .normal)
            btnColorBlue.setImage(UIImage(named: "empty"), for: .normal)
            btnColorGreen.setImage(UIImage(named: "empty"), for: .normal)
            btnColorWhite.setImage(UIImage(named: "empty"), for: .normal)
            SelectecColor = "R"
        }
        else if sender.tag == 9{
            btnColorBlue.setImage(UIImage(named: "accept"), for: .normal)
            btnColorRed.setImage(UIImage(named: "empty"), for: .normal)
            btnColorBlack.setImage(UIImage(named: "empty"), for: .normal)
            btnColorGreen.setImage(UIImage(named: "empty"), for: .normal)
            btnColorWhite.setImage(UIImage(named: "empty"), for: .normal)
            SelectecColor = "Bl"
        }
        else if sender.tag == 10{
            btnColorGreen.setImage(UIImage(named: "accept"), for: .normal)
            btnColorRed.setImage(UIImage(named: "empty"), for: .normal)
            btnColorBlue.setImage(UIImage(named: "empty"), for: .normal)
            btnColorBlack.setImage(UIImage(named: "empty"), for: .normal)
            btnColorWhite.setImage(UIImage(named: "empty"), for: .normal)
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
            return arrCategoryImage.count
        }
        else{
            return arrCategoryImage.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHeaderCollectionViewCell", for: indexPath) as! HomeHeaderCollectionViewCell
            cell.imageHeader.image = UIImage(named: arrCategoryImage[indexPath.row])
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
            let vc = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "ImageDisplayVC") as! ImageDisplayVC
            vc.arrImageDisplay = arrCategoryImage
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    //MARK: User Defined Methods
    
    func setUpMenuButton(isScroll : Bool){
        
        let icon = UIImage(systemName: "chevron.left")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20))
        let iconButton = UIButton(frame: iconSize)
        iconButton.tintColor = isScroll ? .black : .black
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(btnBackClicked), for: .touchUpInside)
        navigationItem.leftBarButtonItem = barButton
       
    }
    
    //MARK: @OBJC Methods
    
    
    @objc func slideToNext(){
        if currentCellIndex < arrCategoryImage .count - 1{
            currentCellIndex = currentCellIndex + 1
        }
        else{
            currentCellIndex = 0
        }
        pageControl.currentPage = currentCellIndex
        collectionSelectedItem.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }
    
    @objc func btnBackClicked(){
        self.navigationController?.popViewController(animated: true)
    }
}

//
//  DetailsScreenVC.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit

class DetailsScreenVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var heightForViewColor: NSLayoutConstraint!
    @IBOutlet weak var viewSizeBtn: UIView!
    @IBOutlet weak var heightForViewSize: NSLayoutConstraint!
    @IBOutlet weak var collectionSelectedItem: UICollectionView!
    
    @IBOutlet weak var viewColor: UIView!
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
    var arrProductName = [""]
    var arrProductPrice = [""]
    var timer : Timer?
    var currentCellIndex = 0
    var SelectecColor = ""
    var SelectedSize = ""
    var Quantity = 1
    var Price   = " "
    var ProductName  = " "
 
    
    //MARK: Application Delegate Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = arrCategoryImage.count
        
        collectionSelectedItem.delegate = self
        collectionSelectedItem.dataSource = self
        collectionSuggestedProducts.delegate = self
        collectionSuggestedProducts.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        lblQuantity.text = "\(Quantity)"
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        scrollView.showsVerticalScrollIndicator = false
        collectionSelectedItem.showsHorizontalScrollIndicator = false
        collectionSuggestedProducts.showsHorizontalScrollIndicator = false
        setUpMenuButton(isScroll: true)
        self.navigationItem.title = "Product Detail"
//        navigationController?.navigationBar.barTintColor = UIColor.white
        setDetailScreenUI()
        lblPrice.text = " $ \(Price)"
        lblProductName.text = ProductName
        setUpSizeColorView()
    }
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            self.collectionSuggestedProducts.reloadData()
            self.collectionSelectedItem.reloadData()
        }
    }
    
    //MARK: IBACTION Method

    @IBAction func onCLickbtnSIze(_ sender: UIButton) {
        btnSizeXS.layer.backgroundColor = UIColor.systemGray5.cgColor
        btnSizeS.layer.backgroundColor = UIColor.systemGray5.cgColor
        btnSizeM.layer.backgroundColor = UIColor.systemGray5.cgColor
        btnSizeL.layer.backgroundColor = UIColor.systemGray5.cgColor
        btnSizeXL.layer.backgroundColor = UIColor.systemGray5.cgColor
        if sender.tag == 1{
            btnSizeXS.backgroundColor = .systemYellow
            SelectedSize = "XS"
        }
        else if sender.tag == 2{
            btnSizeS.backgroundColor = .systemYellow
            SelectedSize = "S"
        }
        else if sender.tag == 3{
            btnSizeM.backgroundColor = .systemYellow
            SelectedSize = "M"
        }
        else if sender.tag == 4{
            btnSizeL.backgroundColor = .systemYellow
            SelectedSize = "L"
        }
        else if sender.tag == 5{
            btnSizeXL.backgroundColor = .systemYellow
            SelectedSize = "XL"
        }
    }
    
    
    @IBAction func onClickBtnColor(_ sender: UIButton) {
        
        btnColorGreen.layer.backgroundColor = UIColor.systemGray5.cgColor
        btnColorBlue.layer.backgroundColor = UIColor.systemGray5.cgColor
        btnColorRed.layer.backgroundColor = UIColor.systemGray5.cgColor
        btnColorBlack.layer.backgroundColor = UIColor.systemGray5.cgColor
        btnColorWhite.layer.backgroundColor = UIColor.systemGray5.cgColor
        
        if sender.tag == 6{
            btnColorWhite.layer.backgroundColor = UIColor.systemYellow.cgColor
            SelectecColor = "W"
        }
        else if sender.tag == 7{
            btnColorRed.layer.backgroundColor = UIColor.systemYellow.cgColor
            SelectecColor = "Bk"
        }
        else if sender.tag == 8{
            btnColorGreen.layer.backgroundColor = UIColor.systemYellow.cgColor
            SelectecColor = "R"
        }
        else if sender.tag == 9{
            btnColorBlue.layer.backgroundColor = UIColor.systemYellow.cgColor
            SelectecColor = "Bl"
        }
        else if sender.tag == 10{
            btnColorBlack.layer.backgroundColor = UIColor.systemYellow.cgColor
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
        btnAddtoCart.backgroundColor = UIColor(named: "AppColor")
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            
            self.btnAddtoCart.backgroundColor = UIColor.systemGray4
                }, completion: nil)
        
        
        guard let dict = ["img":arrCategoryImage[0],"Name":ProductName,"Price":Price,"TotalItem":"\(Quantity)"] as? Dictionary<String, String> else { return  }
        var currentCart = UserDefaults.standard.array(forKey: "MyCart") as! Array<Dictionary<String, String>>
        
        var FoundItem =  currentCart.filter( { $0["Name"] == ProductName } )
       
       
        if FoundItem.count == 0{
            currentCart.insert(dict, at: 0)
            
        }
        else{
            let NewQuantity = (FoundItem[0]["TotalItem"]! as NSString).integerValue + Quantity
            let FoundItemIndex =  currentCart.firstIndex(of: FoundItem[0])
            currentCart.remove(at: FoundItemIndex ?? -1)
            FoundItem[0]["TotalItem"] = "\(NewQuantity)"
            currentCart.append(FoundItem[0])
        }
        UserDefaults.standard.set(currentCart, forKey: "MyCart")
//        print(currentCart)
        
        
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
            cell.lblCategoryName.text = "Product Name goes here"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            let vc = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "ImageDisplayViewController") as! ImageDisplayViewController
            vc.arrImageDisplay = arrCategoryImage
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .fullScreen
            present(vc,animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: collectionView.frame.width, height: 250)
        }
        return CGSize(width: 225, height: 98)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionSelectedItem{
            //            print(scrollView.contentOffset,scrollView.contentInset,scrollView.contentSize)
            guard let visiblecell = collectionSelectedItem.visibleCells.last else { return  }
            let indexpath = collectionSelectedItem.indexPath(for: visiblecell)
            currentCellIndex = indexpath?.row ?? -1
            pageControl.currentPage = currentCellIndex % arrCategoryImage.count
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionSelectedItem.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
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
    
    func setDetailScreenUI(){
        btnSizeXL.layer.cornerRadius = 15
        btnSizeL.layer.cornerRadius = 15
        btnSizeM.layer.cornerRadius = 15
        btnSizeS.layer.cornerRadius = 15
        btnSizeXS.layer.cornerRadius = 15
        
        btnColorGreen.layer.cornerRadius = 15
        btnColorBlue.layer.cornerRadius = 15
        btnColorRed.layer.cornerRadius = 15
        btnColorBlack.layer.cornerRadius = 15
        btnColorWhite.layer.cornerRadius = 15
        
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
        
        btnAddtoCart.layer.cornerRadius = 15
        btnQuantityMinus.layer.cornerRadius = 10
        btnQuantityMinus.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        btnQuantityAdd.layer.cornerRadius = 10
        btnQuantityAdd.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
    }
    
    func setUpSizeColorView(){
        if ProductName.trimmingCharacters(in: .whitespacesAndNewlines) == "TOP" ||  ProductName.trimmingCharacters(in: .whitespacesAndNewlines) == "Tshirt"{
            heightForViewSize.constant = 30
            heightForViewColor.constant = 35
            viewSizeBtn.isHidden = false
            viewColor.isHidden = false
            
        }
        else{
            heightForViewSize.constant = 0
            heightForViewColor.constant = 0
            viewSizeBtn.isHidden = true
            viewColor.isHidden = true
        }
        if ProductName.trimmingCharacters(in: .whitespacesAndNewlines) == "Shoes"{
            heightForViewSize.constant = 30
            viewSizeBtn.isHidden = false
            btnSizeXS.setTitle("8", for: .normal)
            btnSizeS.setTitle("9", for: .normal)
            btnSizeM.setTitle("10", for: .normal)
            btnSizeL.setTitle("11", for: .normal)
            btnSizeXL.setTitle("12", for: .normal)
        }
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

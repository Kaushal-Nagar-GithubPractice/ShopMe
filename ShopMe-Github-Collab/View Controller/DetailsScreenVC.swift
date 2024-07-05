//
//  DetailsScreenVC.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit

class DetailsScreenVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var viewSuggestedProduct: UIView!
    var isAddedtoCart = false
    @IBOutlet weak var heightViewSuggestedProduct: NSLayoutConstraint!
    @IBOutlet weak var collectionColor: UICollectionView!
    @IBOutlet weak var collectionSize: UICollectionView!
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
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var timer : Timer?
    var currentCellIndex = 0
    var SelectedColor = ""
    var SelectedSize = ""
    var Quantity = 1
    var cartItems  = [Get_CartProducts]()
    var selectedProduct : SingleProduct?
    var RelatedProduct = [Products]()
    var isProductInCart = false
    var productID = ""
    var ColorsInCart = [""]
    var SizesInCArt = [""]
    //MARK: Application Delegate Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionSelectedItem.delegate = self
        collectionSelectedItem.dataSource = self
        collectionSuggestedProducts.delegate = self
        collectionSuggestedProducts.dataSource = self
        collectionSize.delegate = self
        collectionSize.dataSource = self
        collectionColor.dataSource = self
        collectionColor.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.callApiSelectedByID(product_id: self.productID)
        callApiRelatedProduct(productId: productID)
        lblQuantity.text = "\(Quantity)"
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        scrollView.showsVerticalScrollIndicator = false
        collectionSelectedItem.showsHorizontalScrollIndicator = false
        collectionSuggestedProducts.showsHorizontalScrollIndicator = false
        setUpMenuButton(isScroll: true)
        setDetailScreenUI()
        print(productID)
        callApiGetCartItems()
       
    }
    override func viewDidAppear(_ animated: Bool) {
        if !(selectedProduct?.images?.count == 1) {
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            self.collectionSuggestedProducts.reloadData()
            self.collectionSelectedItem.reloadData()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        SelectedSize = ""
        SelectedColor = ""
        
    }
    
    //MARK: IBACTION Method
    
    @IBAction func onClickPlus(_ sender: Any) {
        if Quantity >= 100 {
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
//        print(isProductInCart)
//        if isProductInCart {
//            ProfileScreenVC.Delegate.ChangeToHomeScreen(tabbarItemIndex : 2)
//        }
//        else{
//            btnAddtoCart.backgroundColor = UIColor.systemGray4
//            
//            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
//                
//                self.btnAddtoCart.backgroundColor = UIColor(named: "AppColor")
//                    }, completion: nil)
//            
////            guard let dict = ["img":arrCategoryImage[0],"Name":ProductName,"Price":Price,"TotalItem":"\(Quantity)","isAdded":"true"] as? Dictionary<String, String> else { return  }
//            var currentCart = UserDefaults.standard.array(forKey: "MyCart") as! Array<Dictionary<String, String>>
//            
////            var FoundItem =  currentCart.filter( { $0["Name"] == ProductName } )
//           
////            currentCart.insert(dict, at: 0)
//           
////            if FoundItem.count == 0{
////                currentCart.insert(dict, at: 0)
////                
////            }
////            else{
////                let NewQuantity = (FoundItem[0]["TotalItem"]! as NSString).integerValue + Quantity
////                let FoundItemIndex =  currentCart.firstIndex(of: FoundItem[0])
////                currentCart.remove(at: FoundItemIndex ?? -1)
////                FoundItem[0]["TotalItem"] = "\(NewQuantity)"
////                currentCart.append(FoundItem[0])
////                
////            }
//            UserDefaults.standard.set(currentCart, forKey: "MyCart")
//            isProductAddedtoCart()
//        }
        if isAddedtoCart {
            ProfileScreenVC.Delegate.ChangeToHomeScreen(tabbarItemIndex: 2)
        }
        else{
            btnAddtoCart.backgroundColor = UIColor.systemGray4
                        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                            self.btnAddtoCart.backgroundColor = UIColor(named: "AppColor")
                                }, completion: nil)
            var dict : Dictionary<String,Dictionary<String, Any>> = [:]
            if SelectedSize != "" && SelectedColor != "" {
                dict = ["product" : ["productId" : selectedProduct?._id ?? "","quantity" : Quantity,"price" : selectedProduct?.price ?? 999,"color" : SelectedColor,"size" : SelectedSize]]
                callAddtoCartApi(dict: dict)
                btnAddtoCart.setTitle(" Go To Cart", for: .normal)
                isAddedtoCart = true
                ShowAlertBox(Title: "Confirmation", Message: "Added to Cart Successfully")
            }
            else{
                if SelectedSize == "" {
                   ShowAlertBox(Title: "Alert", Message: "Select Size For Product ")
                }
                else if SelectedColor == "" {
                    ShowAlertBox(Title: "Alert", Message: "Select Color For Product ")
                }
                else if  SelectedSize == "" && SelectedColor == "" {
                    ShowAlertBox(Title: "Alert", Message: "Select Size & Color For Product ")
                }
            
            }
            
        }
        
    }
    
    //MARK: Delegate Method
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            if (selectedProduct?.images?.count ?? 0) > 1 {
                return (selectedProduct?.images?.count ?? 1) * 1000
            }else{return 1}
        }
        else if collectionView == collectionSize  {
            return selectedProduct?.size?.count ?? 0
        }
        else if collectionView == collectionColor {
            return selectedProduct?.colors?.count ?? 0
        }
        else{
            return RelatedProduct.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionSelectedItem {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHeaderCollectionViewCell", for: indexPath) as! HomeHeaderCollectionViewCell
            if selectedProduct?.images?.count != 0{
                cell.imageHeader.setImageWithURL(url: selectedProduct?.images?[indexPath.row % (selectedProduct?.images?.count ?? 3)] ?? "", imageView: cell.imageHeader)
            }
            else{
                cell.imageHeader.image = UIImage(named: "placeholder")
            }
            cell.viewHeader.backgroundColor = .systemGray5
            cell.viewHeader.layer.cornerRadius = 25
            cell.viewHeader.layer.masksToBounds = true
            return cell
        }
        else if collectionView == collectionSize || collectionView == collectionColor {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsCollectionViewCell", for: indexPath) as! ProductDetailsCollectionViewCell
            if collectionView == collectionSize {
                cell.lblChoice.text = selectedProduct?.size?[indexPath.row] ?? ""
//                SelectedSize = selectedProduct?.size?.first ?? ""
            }
            else{
                cell.lblChoice.text = selectedProduct?.colors?[indexPath.row] ?? ""
//                SelectedColor = selectedProduct?.colors?.first ?? ""
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            cell.imageCategories.setImageWithURL(url: RelatedProduct[indexPath.row].images?.first ?? "", imageView: cell.imageCategories)
            cell.lblCategoryName.text = RelatedProduct[indexPath.row].productName
            cell.lblCategoryQuantity.text = "$\(RelatedProduct[indexPath.row].price ?? 999)"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 1 {
            let cell = collectionView.cellForItem(at: indexPath) as! HomeHeaderCollectionViewCell
            if cell.imageHeader.image != UIImage(named: "placeholder"){
                let vc = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "ImageDisplayViewController") as! ImageDisplayViewController
                vc.arrImageDisplay = selectedProduct?.images ?? []
                vc.modalTransitionStyle = .coverVertical
                vc.modalPresentationStyle = .fullScreen
                present(vc,animated: true)
            }
            
        }else if collectionView.tag == 2 {
            let cell = collectionView.cellForItem(at: indexPath) as! ProductDetailsCollectionViewCell
            SelectedSize = selectedProduct?.size?[indexPath.row] ?? ""
            cell.viewChoice.backgroundColor = .systemTeal
            isSelectedSizeColorInCart()
        }
        else if collectionView.tag == 3 {
            let cell = collectionView.cellForItem(at: indexPath) as! ProductDetailsCollectionViewCell
            SelectedColor = selectedProduct?.colors?[indexPath.row] ?? ""
            cell.viewChoice.backgroundColor = .systemTeal
            isSelectedSizeColorInCart()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ProductDetailsCollectionViewCell
        if collectionView.tag == 2 {
            cell.viewChoice.backgroundColor = .systemGray5
        }
        else if collectionView.tag == 3 {
            cell.viewChoice.backgroundColor = .systemGray5
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionSelectedItem {
            return CGSize(width: collectionView.frame.width, height: 250)
        } else if collectionView == collectionSize {
            return CGSize(width: 60, height: 35)
        }
        else if collectionView == collectionColor{
            return CGSize(width: 75, height: 35)
        }
        else{
            return CGSize(width: 225, height: 98)
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionSelectedItem{
            guard let visiblecell = collectionSelectedItem.visibleCells.last else { return  }
            let indexpath = collectionSelectedItem.indexPath(for: visiblecell)
            currentCellIndex = indexpath?.row ?? -1
            pageControl.currentPage = currentCellIndex % (selectedProduct?.images?.count ?? 3)
            collectionSelectedItem.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
        }
    }
    
    //MARK: API CAllING Methods
    
  
    func callApiGetCartItems(){
        let request = APIRequest(isLoader: true, method: HTTPMethods.get, path: Constant.GET_ALL_CART_ITEMS, headers: HeaderValue.headerWithToken.value, body: nil)
        
        Get_CartItemsViewModel.ApiGetCart.getAddToCartData(request: request) { response in
	            DispatchQueue.main.async {
                if response.data?.products?.count != 0 {
                    self.cartItems = response.data?.products ?? []
                    self.isProductAddedtoCart()
                }
            }
        } error: { error in
            print(error)
        }
    }
    
    func callApiSelectedByID(product_id : String){
        let request = APIRequest(isLoader: true, method: HTTPMethods.get, path: Constant.GET_PRODUCT+productID, headers: HeaderValue.headerWithoutAuthToken.value, body: nil)
        
        ProductByIdViewModel.ApiProductByID.getSingleProductData(request: request, success: { response in
            self.selectedProduct = response.data!
            DispatchQueue.main.async {
//                print(response)
                self.updateUIAfterAPI()
                self.collectionSelectedItem.reloadData()
                self.collectionSize.reloadData()
                self.collectionColor.reloadData()
            }
        }, error: { error in
            print(error ?? "Error")
        })
    }
    
    func callApiRelatedProduct(productId : String){
        let request = APIRequest(isLoader: true, method: HTTPMethods.get, path: Constant.GET_RELATED_LIST+productID, headers: HeaderValue.headerWithoutAuthToken.value, body: nil)
        ProductViewModel.ApiProduct.getProductData(request: request) { response in
            DispatchQueue.main.async {
                if response.data?.products?.isEmpty == true{
                    print(response.data?.products?.isEmpty)
                    print(response.status as Any,response.message as Any)
                    self.viewSuggestedProduct.isHidden = true
                    self.heightViewSuggestedProduct.constant = 0
                }
                else{
//                    print(response.data?.products)
                    self.RelatedProduct = response.data?.products ?? []
                    self.collectionSuggestedProducts.reloadData()
                }
            }
        } error: { error in
            print(error as Any)
        }
    }
    
    func callAddtoCartApi(dict :Dictionary<String,Dictionary<String,Any>>){
        let request = APIRequest(isLoader: true, method: HTTPMethods.post, path: Constant.ADD_TO_CART, headers: HeaderValue.headerWithToken.value, body: dict)
        ProductAddToCartViewModel.ApiAddToCart.getAddToCartData(request: request) { response in
            print("----------------",response,"-------------------------")
        } error: { error in
            print(error)
        }
    }
    
    //MARK: User Defined Methods
    func isProductAddedtoCart(){
        let FoundItem = cartItems.filter( { $0.productId == selectedProduct?._id})
        print(FoundItem)
        if FoundItem.count == 0{
            btnAddtoCart.setTitle(" Add to Cart", for: .normal)
            isAddedtoCart = false
        }
        else{
            getCartSizesColors()
            isAddedtoCart = true
            btnAddtoCart.setTitle(" Go to Cart", for: .normal)
            btnQuantityAdd.isEnabled = false
            btnQuantityMinus.isEnabled = false
            }
    }
    func getCartSizesColors(){
      ColorsInCart = []
        SizesInCArt = []
        for i in 0..<(cartItems.count){
            ColorsInCart.append(cartItems[i].color ?? "")
            SizesInCArt.append(cartItems[i].size ?? "")
        }
    }
    
    func isSelectedSizeColorInCart(){
        if ColorsInCart.contains(SelectedColor) && SizesInCArt.contains(SelectedSize) {
            isAddedtoCart = true
            btnAddtoCart.setTitle(" Go to Cart", for: .normal)
        }
        else{
            isAddedtoCart = false
            btnAddtoCart.setTitle(" Add to Cart", for: .normal)
        }
    }
    
    
    func updateUIAfterAPI(){
        pageControl.numberOfPages = selectedProduct?.images?.count ?? 3
        if selectedProduct?.images?.count == 1 {
            timer?.invalidate()
        }
        if selectedProduct?.size?.count == 0 {
            heightForViewSize.constant = 0
            viewSizeBtn.isHidden = true
        }
        if selectedProduct?.colors?.count == 0 {
            heightForViewColor.constant = 0
            viewColor.isHidden = true
        }
        lblDescription.text = selectedProduct?.mainDescription ?? ""
        self.navigationItem.title = selectedProduct?.productName
        lblPrice.text = " $ \(selectedProduct?.price  ?? 1234)"
    }
    
    func setUpMenuButton(isScroll: Bool) {
        let icon = UIImage(systemName: "chevron.left")
        let iconSize = CGRect(origin: CGPoint.init(x: 0, y: 0), size: CGSize(width: 20, height: 25))
        let iconButton = UIButton(frame: iconSize)
        iconButton.tintColor = isScroll ? .label : .label
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(btnBackClicked), for: .touchUpInside)
        navigationItem.leftBarButtonItem = barButton
        self.navigationItem.title = selectedProduct?.productName
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func setDetailScreenUI(){
        
        btnAddtoCart.layer.cornerRadius = 15
        btnQuantityMinus.layer.cornerRadius = 10
        btnQuantityMinus.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        btnQuantityAdd.layer.cornerRadius = 10
        btnQuantityAdd.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
    }
 
    
    //MARK: @OBJC Methods
    
    
    @objc func slideToNext(){
        
        if selectedProduct?.images?.count != 0 {
            currentCellIndex = currentCellIndex + 1
            pageControl.currentPage = currentCellIndex % (selectedProduct?.images?.count ?? 3)
            collectionSelectedItem.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
        }
        
    }
    
    @objc func btnBackClicked(){
        self.navigationController?.popViewController(animated: true)
    }
}

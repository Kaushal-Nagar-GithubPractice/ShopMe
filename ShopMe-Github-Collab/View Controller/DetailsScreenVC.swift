//
//  DetailsScreenVC.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit
import Cosmos
import SVProgressHUD
class DetailsScreenVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var isRatingAdded = false
    var isWishlist = false
    @IBOutlet weak var addToWishlist: UIButton!
    @IBOutlet weak var tblUserReviews: UITableView!
    @IBOutlet weak var UserRating: CosmosView!
    @IBOutlet weak var viewSuggestedProduct: UIView!
    @IBOutlet weak var txtViewUserRating: UITextView!
    var isAddedtoCart = false
    @IBOutlet weak var btnAddUserRating: UIButton!
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
    var ArrReview = [Reviews]()
    @IBOutlet weak var heightForTblRating: NSLayoutConstraint!
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
        getUserRatings()
        print(isWishlist)
        btnWishList()
       
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
    @IBAction func onClickAddToWishList(_ sender: Any) {
        if isWishlist{
            let URL = Constant.Delete_Product_From_Wishlist_URL + productID
            
            let request  = APIRequest(isLoader: true, method: .delete, path: URL, headers: HeaderValue.headerWithToken.value, body: nil)
            
            CallAPIToDeleteProductFromWishlist(request: request)
            
        }
        else{
            if UserDefaults.standard.bool(forKey: "IsRedirect"){
                callApiWishList(productId: productID)
                isWishlist = true
                btnWishList()
            }
        }
     
    }
    @IBAction func onCLickAddtoCart(_ sender: Any) {
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
                dict = ["product" : ["productId" : selectedProduct?._id ?? "","quantity" : Quantity,"price" : selectedProduct?.sellingPrice ?? 999,"color" : SelectedColor,"size" : SelectedSize]]
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
    
    
    @IBAction func onClickAddRating(_ sender: Any) {
        if UserRating.rating == 0 {
            ShowAlertBox(Title: "Alert", Message: "please give your ratings")
        }
        else if txtViewUserRating.text.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtViewUserRating.text.trimmingCharacters(in: .whitespacesAndNewlines) == "Add Review"{
            ShowAlertBox(Title: "Alert", Message: "please add your review")
        }
        else {
            //            print(UserRating.rating,txtViewUserRating.text ?? "demo")
            if UserDefaults.standard.bool(forKey: "IsRedirect"){
                var dictRating = [
                    "rating" : UserRating.rating,
                    "review" : txtViewUserRating.text ?? "demo"
                ] as [String : Any]
                callApiAddRating(dictRating: dictRating)
            }
            
            else{
                showAlert(title: "Alert", message: "Please Login to Add Review")
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
            }
            else{
                cell.lblChoice.text = selectedProduct?.colors?[indexPath.row] ?? ""
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            cell.imageCategories.setImageWithURL(url: RelatedProduct[indexPath.row].images?.first ?? "", imageView: cell.imageCategories)
            cell.lblCategoryName.text = RelatedProduct[indexPath.row].productName
            cell.lblCategoryQuantity.text = "$\(RelatedProduct[indexPath.row].sellingPrice ?? 999)"
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
        
        if collectionView.tag == 2 {
            let cell = collectionView.cellForItem(at: indexPath) as! ProductDetailsCollectionViewCell
            cell.viewChoice.backgroundColor = .systemGray5
            SelectedSize = ""
            isSelectedSizeColorInCart()
        }
        else if collectionView.tag == 3 {
            let cell = collectionView.cellForItem(at: indexPath) as! ProductDetailsCollectionViewCell
            cell.viewChoice.backgroundColor = .systemGray5
            SelectedColor = ""
            isSelectedSizeColorInCart()
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
    
    func callApiAddRating(dictRating : [String : Any]) {
        let request = APIRequest(isLoader: true, method: HTTPMethods.post, path: Constant.POST_PRODUCT_RATING+productID, headers: HeaderValue.headerWithToken.value, body: dictRating)
        
        UserRatingViewModel.ApiPostRatings.getPostRatingData(request: request) { response in
            DispatchQueue.main.async {
                print(response)
                if response.status == 200 && response.success == true {
                    self.ShowAlertBox(Title: "Message", Message: "Your Ratings are Added Successfully")
                    self.getUserRatings()
//                    self.tblUserReviews.reloadData()
                }
                else if response.status == 400{
                    self.ShowAlertBox(Title: "Message", Message: "You have already added Ratings for this product")
                }
                else{
                    self.ShowAlertBox(Title: "Message", Message: "Something Went Wrong")
                }
            }
        } error: { error in
            print(error as Any)
        }
        
    }
    func callApiWishList(productId : String){
        let request = APIRequest(isLoader: true, method: HTTPMethods.post, path: Constant.ADD_TO_WHISLIST+productId, headers: HeaderValue.headerWithToken.value, body: nil)
        Post_WishlistViewModel.ApiAddWishlist.getPostRatingData(request: request) { response in
            DispatchQueue.main.async {
                SVProgressHUD.setDefaultMaskType(.black)
                SVProgressHUD.show()
                print(response)
                if (response.success == true ){
                    self.ShowAlertBox(Title: "Confirmation", Message: "Added to WishList Sucessfully")
                    
                }
                else{
//
                }
                SVProgressHUD.dismiss()
            }
            
        } error: { error in
            print(error)
        }

    }
    func getUserRatings(){
        let request = APIRequest(isLoader: true, method: HTTPMethods.get, path: Constant.GET_REVIEW_LIST+productID, headers: HeaderValue.headerWithToken.value, body: nil)
        UserRatingViewModel.ApiPostRatings.getPostRatingData(request: request) { response in
            DispatchQueue.main.async {
                print(response)
                if response.data?.reviews?.count != 0 {
                    self.ArrReview = response.data?.reviews ?? []
                    self.tblUserReviews.reloadData()
                    self.tblUserReviews.isHidden = false
                    self.heightForTblRating.constant = CGFloat(150 *  (response.data?.reviews?.count ?? 1) + 75)
                }
                else{
                    self.tblUserReviews.isHidden = true
                    self.heightForTblRating.constant = 0
                }
            }
        } error: { error in
            print(error as Any)
        }
    }
    
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
        ProductAddToCartViewModel.ApiAddToCart.getAddToCartData(request: request) { [self] response in
//            print("----------------",response,"-------------------------")
            DispatchQueue.main.async {
//                Quantity = 1
//                lblQuantity = ""
                self.btnQuantityAdd.isEnabled = false
                btnQuantityMinus.isEnabled = false
            }
        } error: { error in
            print(error)
        }
    }
    
    //MARK: User Defined Methods
    
    func CallAPIToDeleteProductFromWishlist(request: APIRequest){ APIClient().perform(request)
        { (data,Error) in
        if let data = data {
            DispatchQueue.main.async {
                self.isWishlist = false
                self.btnWishList()
                
                self.ShowAlertBox(Title: "Confirmation", Message: "Removed From Wishlist Successfully !!")
            }
        } else {
            
        }
    }
    }
    
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
    func btnWishList(){
        if isWishlist {
            addToWishlist.tintColor = .red
        }
        else{
            addToWishlist.tintColor = .systemGray2
        }
    }
    
    func isSelectedSizeColorInCart(){
        if ColorsInCart.contains(SelectedColor) && SizesInCArt.contains(SelectedSize) {
            isAddedtoCart = true
            btnQuantityAdd.isEnabled = false
            btnQuantityMinus.isEnabled = false
            btnAddtoCart.setTitle(" Go to Cart", for: .normal)
        }
        else{
            isAddedtoCart = false
            btnQuantityAdd.isEnabled = true
            btnQuantityMinus.isEnabled = true
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
        lblPrice.text = " $ \(selectedProduct?.sellingPrice  ?? 1234)"
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
        tblUserReviews.isScrollEnabled = false
        btnAddtoCart.layer.cornerRadius = 15
        btnQuantityMinus.layer.cornerRadius = 10
        btnQuantityMinus.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        btnQuantityAdd.layer.cornerRadius = 10
        btnQuantityAdd.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
//        UserRating.settings.fillMode = .precise
        txtViewUserRating.layer.cornerRadius = 12
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

extension DetailsScreenVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserReviewsTableViewCell", for: indexPath) as! UserReviewsTableViewCell
        cell.btnRatings.setTitle("   \(ArrReview[indexPath.row].rating ?? 5)", for: .normal)
        cell.lblUsername.text = ArrReview[indexPath.row].name
        cell.lblUserReview.text = "   \(ArrReview[indexPath.row].review ?? "")"
        return cell
    }
    
    
}

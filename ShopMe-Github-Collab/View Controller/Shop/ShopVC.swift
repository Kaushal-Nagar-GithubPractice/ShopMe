//
//  ShopVC.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 25/06/24.
//

import UIKit
import SVProgressHUD

var Global_scrollView : UIScrollView?
class ShopVC: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UISearchBarDelegate, SelectedFilter {
//    var isFirstTimeApiCall = true
    @IBOutlet weak var viewEmptyProduct: UIView!
    var flagForPgCntFilterPrdt = false
    var pageForFilterPdt = 1
    var isSearchBarEmpty = true
    @IBOutlet weak var ViewMain: UIView!
    var MainArr  = [Product_Data]()
    var filterData = [Products]()
    @IBOutlet weak var searchBar: UISearchBar!
    var pageCountForSearchText = 1
    var arrData = [Products]()
    var allFilteresProduct = [Products]()
    @IBOutlet weak var collectionProducts: UICollectionView!
    var flagForEmptyProdCall = true
    var pageCount = 1
    var eneteredSearchText = ""
    var color = [""]
    var size = [""]
    var filterUrl = ""
    var ShopProducts = [Products]()
    var dictFilters : FilterDictModel?

    
    //MARK: APPLICATION DELEGATE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionProducts.dataSource = self
        collectionProducts.delegate = self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        self.tabBarController?.tabBar.isHidden = false
        self.collectionProducts.showsVerticalScrollIndicator = false
        searchBar.text = ""
        flagForEmptyProdCall = true
        pageCount = 1
        pageCountForSearchText = 1
        isSearchBarEmpty = true
        arrData = []
        filterData = []
        self.viewEmptyProduct.isHidden = true
        setUpMenuButton(isScroll: true)
//        collectionProducts.reloadData()
//        if isFirstTimeApiCall{
            callApiProduct()
//        }
        
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            self.collectionProducts?.reloadData()
        }
    }
    
    //MARK: SEARCHBAR DELEGATE  METHODS
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let enteredText = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if enteredText != "" {
            isSearchBarEmpty = false
            
        }
        else{
            isSearchBarEmpty = true
            filterData = []
            
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            self.callApiProduct(searchText:enteredText ?? "")
        }
        eneteredSearchText = enteredText ?? ""
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
    }
    
    //MARK: COLLECTIONVIEW DELEGATE METHODS
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return ShopProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as! ProductsCollectionViewCell
            cell.imgProduct.setImageWithURL(url: ShopProducts[indexPath.row].images?.first ?? " ", imageView: cell.imgProduct)
            cell.lblProductName.text =  ShopProducts[indexPath.row].productName
            cell.lblPrice.text =  "₹ \(ShopProducts[indexPath.row].price ?? 123)"
            cell.lblStrikePrice.isHidden = true
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "DetailsScreenVC") as! DetailsScreenVC
            vc.productID = ShopProducts[indexPath.row]._id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 5, height: 285)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + self.view.frame.height - 150 >= collectionProducts.contentSize.height {
                if flagForEmptyProdCall {
                    if isSearchBarEmpty {
                        pageCount += 1
                        callApiProduct(searchText: "")
                    }
                    else{
                        pageCountForSearchText += 1
                        callApiProduct(searchText: eneteredSearchText)
                    }
                    if flagForPgCntFilterPrdt == true {
                        pageForFilterPdt += 1
                        callApiFilteredProduct(urlString: filterUrl)
                    }
                    
                }
            }
    }
    
    //MARK: API CALLING  METHODS
    
    func callApiProduct(searchText : String = ""){
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        if isSearchBarEmpty {
            let request = APIRequest(isLoader: true, method: HTTPMethods.get, path: Constant.GET_PRODUCT_LIST+"?page=\(pageCount)&items=6", headers: HeaderValue.headerWithoutAuthToken.value, body: nil)
            ProductViewModel.ApiProduct.getProductData(request: request) { response in
                DispatchQueue.main.async {
                    if response.data?.products?.isEmpty == true{
                        print(response.status as Any,response.message as Any)
                        self.flagForEmptyProdCall = false
                        self.viewEmptyProduct.isHidden = false
                        SVProgressHUD.dismiss()
                        
                    }
                    else{
                        self.viewEmptyProduct.isHidden = true
                        self.arrData = response.data?.products ?? []
                        self.MainArr.append(response.data!)
                        self.ShopProducts = self.arrData
                        self.getSizeAndColor()
                        print(self.arrData.count as Any)
                        self.collectionProducts.reloadData()
                        
                        SVProgressHUD.dismiss()
//                        self.isFirstTimeApiCall = true
                    }
                }
            } error: { error in
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    self.viewEmptyProduct.isHidden = false
                    self.ShowAlertBox(Title: "Alert", Message: "\(error!)")
                    print(error as Any)
                }
            }
        }
            else {
            let request = APIRequest(isLoader: true, method: HTTPMethods.get, path: Constant.GET_PRODUCT_LIST+"?page=\(pageCountForSearchText)&items=8"+"&search="+searchText, headers: HeaderValue.headerWithoutAuthToken.value, body: nil)
            print("-----------------------",Constant.GET_PRODUCT_LIST+"?page=\(pageCountForSearchText)&items=8"+"&search="+searchText)
                ProductViewModel.ApiProduct.getProductData(request: request) { response in
                DispatchQueue.main.async {
                    if response.data?.products?.isEmpty == true{
                        if response.data?.products?.isEmpty == true && response.data?.page == 1 {
                            SVProgressHUD.dismiss()
//                            self.ShowAlertBox(Title: "Alert", Message: "No Such Product Or Category found")
                            self.viewEmptyProduct.isHidden = false
                        }
                        print(response.status as Any,response.message as Any)
                        self.flagForEmptyProdCall = false
                        self.viewEmptyProduct.isHidden = false
                        SVProgressHUD.dismiss()
                    }
                    else{
                        self.viewEmptyProduct.isHidden = true
                        self.filterData = response.data?.products ?? []
                        self.MainArr.append(response.data!)
                        self.ShopProducts = self.filterData
                        self.getSizeAndColor()
                        print(self.filterData.count as Any)
                        self.collectionProducts.reloadData()
                        SVProgressHUD.dismiss()
                    }
                }
                } error: { error in
                    DispatchQueue.main.async {
                        self.viewEmptyProduct.isHidden = false
                        SVProgressHUD.dismiss()
                        self.ShowAlertBox(Title: "Alert", Message: "\(error!)")
                        print(error as Any)
                        
                    }
                }
        }
    }
    
    func callApiFilteredProduct(urlString : String){
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        let request = APIRequest(isLoader: true, method: HTTPMethods.get, path: Constant.GET_PRODUCT_LIST+"?page=\(pageCountForSearchText)&items=8"+urlString, headers: HeaderValue.headerWithoutAuthToken.value, body: nil)
        print("------------------------",Constant.GET_PRODUCT_LIST+"?page=\(pageCountForSearchText)&items=8"+urlString)
        ProductViewModel.ApiProduct.getProductData(request: request) { response in
            DispatchQueue.main.async {
                if response.data?.products?.isEmpty == true{
                    if response.data?.products?.isEmpty == true && response.data?.page == 1 {
                        SVProgressHUD.dismiss()
                        self.ShowAlertBox(Title: "Alert", Message: "No Such Product Or Category found")
                        self.searchBar.text = ""
                        self.isSearchBarEmpty = true
//                        self.ShopProducts = []
//                        self.callApiProduct()
                        self.viewEmptyProduct.isHidden = false
                    }
                    print(response.status as Any,response.message as Any)
                    self.flagForEmptyProdCall = false
                    self.flagForPgCntFilterPrdt  = false
                    SVProgressHUD.dismiss()
                }
                else{
                    self.viewEmptyProduct.isHidden = true
//                    print(response)
                    self.allFilteresProduct =  response.data?.products ?? []
//                    print(self.allFilteresProduct,self.ShopProducts)
                    self.ShopProducts = self.allFilteresProduct
//                    print(self.allFilteresProduct,self.ShopProducts)
                    self.collectionProducts.reloadData()
                    SVProgressHUD.dismiss()
                }
            }
        } error: { error in
            DispatchQueue.main.async {
                self.viewEmptyProduct.isHidden = false
                SVProgressHUD.dismiss()
                self.ShowAlertBox(Title: "Alert", Message: "\(error!)")
                print(error as Any)
            }
        }
    }
    
    //MARK: USERDEFINED  METHODS
    
    func setUpMenuButton(isScroll : Bool){
        
        let icon = UIImage(named: "setting")
        let iconSize = CGRect(origin: CGPoint.init(x: 10, y: 0), size: CGSize(width: 20, height: 18))
        let iconButton = UIButton(frame: iconSize)
        iconButton.tintColor = UIColor(named: "Custom Black")
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(btnFilterClicked), for: .touchUpInside)
        navigationItem.rightBarButtonItem = barButton
        self.navigationItem.title = "Shop"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)]
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    func getSizeAndColor(){
        color = []
        size = []
        for i in 0..<(MainArr.first?.products?.count ?? 0){
            for j in 0..<(MainArr.first?.products?[i].colors?.count ?? 0){
                if !(color.contains(MainArr.first?.products?[i].colors?[j] ?? "")) {
                    color.append(MainArr.first?.products?[i].colors?[j] ?? "")
                }
            }
            for k in 0..<(MainArr.first?.products?[i].size?.count ?? 0){
                if !(size.contains(MainArr.first?.products?[i].size?[k] ?? "")){
                    size.append(MainArr.first?.products?[i].size?[k] ?? "")
                }
            }
        }
    }
    
    func resetOnAppear() {
           pageCount = 1
           pageCountForSearchText = 1
//           pageForFilterProduct = 1
//           flagForEmptyProductCall = true
//           isFilterActive = false
//           allProducts = []
//           searchResults = []
//           filteredProducts = []
//           displayedProducts = []
           collectionProducts.reloadData()
       }

       func resetSearchArr() {
           pageCountForSearchText = 1
//           flagForEmptyProductCall = true
//           searchResults = []
//           displayedProducts = []
           collectionProducts.reloadData()
       }

       func resetFilterArr() {
//           pageForFilterProduct = 1
//           flagForEmptyProductCall = true
//           filteredProducts = []
//           displayedProducts = []
           collectionProducts.reloadData()
       }
    //MARK: OBJC  METHODS

    @objc func btnFilterClicked(){
        searchBar.text = ""
        let vc = UIStoryboard(name: "ShopStoryboard", bundle: nil).instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        vc.sheetPresentationController?.detents = [.medium()]
        vc.modalTransitionStyle = .coverVertical
        vc.dictFilters = dictFilters
        if dictFilters?.minPrice != 0 || dictFilters?.maxPrice != 0 || (dictFilters?.color != [""]) || (dictFilters?.size != [""]) {
            vc.flagForAppliedFilter = true
        }
       
        vc.minPrice = 0
        vc.maxPrice = MainArr.first?.max_price ?? 1000
        vc.arrSize = size
        vc.arrColor = color
        vc.delegate = self
        present(vc,animated:true)
        
    }
    //MARK: Protocol  METHODS
    func onClickApplyFilter(dict: FilterDictModel) {
        searchBar.text = ""
        filterUrl = ""
        flagForPgCntFilterPrdt = true
        if !(dict.minPrice == 0) {
            filterUrl += "&minPrice="+"\(dict.minPrice)"
        }
        if !(dict.maxPrice == 0) {
            filterUrl += "&maxPrice="+"\(dict.maxPrice)"
        }
        if !(dict.size == [""]) {
            for i in 0..<dict.size.count{
                filterUrl += "&size[\(i)]="+"\(dict.size[i])"
            }
        }
        if !(dict.color == [""]) {
            for i in 0..<dict.color.count{
                filterUrl += "&color[\(i)]="+"\(dict.color[i])"
            }
        }
        print(filterUrl)
        dictFilters = dict
        callApiFilteredProduct(urlString: filterUrl)
    }
    
    
}

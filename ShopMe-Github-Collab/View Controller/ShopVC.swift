//
//  ShopVC.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 25/06/24.
//

import UIKit
protocol changesInTransition {
    func viewwillTranition(size: CGSize)
}
class ShopVC: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var isSearchBarEmpty = false
    @IBOutlet weak var ViewMain: UIView!
    var filterData = [Products]()
    @IBOutlet weak var searchBar: UISearchBar!
    var pageCountForSearchText = 1
    var arrData = [Products]()
    @IBOutlet weak var collectionProducts: UICollectionView!
    var flagForEmptyProdCall = true
    var pageCount = 1
    var eneteredSearchText = ""
    
    //MARK: APPLICATION DELEGATE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionProducts.dataSource = self
        collectionProducts.delegate = self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.collectionProducts.showsVerticalScrollIndicator = false
        setUpMenuButton(isScroll: true)
        collectionProducts.reloadData()
        callApiProduct()
        
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
        }
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) {_ in
            print(enteredText)
            self.callApiProduct(searchText:enteredText ?? "")
            self.collectionProducts.reloadData()
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
        if isSearchBarEmpty {
            return arrData.count
        }
        else{
            return filterData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as! ProductsCollectionViewCell
        if isSearchBarEmpty {
            cell.imgProduct.setImageWithURL(url: arrData[indexPath.row].images?.first ?? " ", imageView: cell.imgProduct)
            cell.lblProductName.text =  arrData[indexPath.row].productName
            cell.lblPrice.text =  "$ \(arrData[indexPath.row].price ?? 123)"
            cell.lblStrikePrice.isHidden = true
        }
        else{
            cell.imgProduct.setImageWithURL(url: filterData[indexPath.row].images?.first ?? " ", imageView: cell.imgProduct)
            cell.lblProductName.text =  filterData[indexPath.row].productName
            cell.lblPrice.text =  "$ \(filterData[indexPath.row].price ?? 123)"
            cell.lblStrikePrice.isHidden = true
        }
       
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "DetailsScreenVC") as! DetailsScreenVC
        if isSearchBarEmpty {
            vc.productID = arrData[indexPath.row]._id ?? ""
        }
        else{
            vc.productID = filterData[indexPath.row]._id ?? ""
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 5, height: 285)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
        iconButton.addTarget(self, action: #selector(btnBackClicked), for: .touchUpInside)
        navigationItem.rightBarButtonItem = barButton
        self.navigationItem.title = "Shop"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)]
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    func callApiProduct(searchText : String = ""){
        if isSearchBarEmpty {
            let request = APIRequest(isLoader: true, method: HTTPMethods.get, path: Constant.GET_PRODUCT_LIST+"?page=\(pageCount)&items=6", headers: HeaderValue.headerWithoutAuthToken.value, body: nil)
            ProductViewModel.ApiProduct.getProductData(request: request) { response in
                DispatchQueue.main.async {
                    if response.data?.products?.isEmpty == true{
                        print(response.status as Any,response.message as Any)
                        self.flagForEmptyProdCall = false
                    }
                    else{
                        self.arrData.append(contentsOf: response.data?.products ?? [])
                        print(self.arrData.count as Any)
                        self.collectionProducts.reloadData()
                    }
                }
            } error: { error in
                print(error as Any)
            }
        }
            else {
            let request = APIRequest(isLoader: true, method: HTTPMethods.get, path: Constant.GET_PRODUCT_LIST+"?page=\(pageCountForSearchText)&items=10"+"&search="+searchText, headers: HeaderValue.headerWithoutAuthToken.value, body: nil)
            
                ProductViewModel.ApiProduct.getProductData(request: request) { response in
                DispatchQueue.main.async {
                    if response.data?.products?.isEmpty == true{
                        print(response.status as Any,response.message as Any)
                        self.flagForEmptyProdCall = false
                    }
                    else{
                        self.filterData.append(contentsOf: response.data?.products ?? [])
                        print(self.filterData.count as Any)
                        self.collectionProducts.reloadData()
                    }
                }
            } error: { error in
                print(error as Any)
            }
        }
    }
    //MARK: OBJC  METHODS

    @objc func btnBackClicked(){
        let vc = UIStoryboard(name: "ShopStoryboard", bundle: nil).instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        vc.sheetPresentationController?.detents = [.medium()]
        vc.modalTransitionStyle = .coverVertical
        present(vc,animated:true)
        
    }


}

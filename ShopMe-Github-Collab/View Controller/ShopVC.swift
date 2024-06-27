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
   
    
    @IBOutlet weak var ViewMain: UIView!
    var arrData = [ProductModel]()
    var filterData = [ProductModel]()
    @IBOutlet weak var searchBar: UISearchBar!
    var arrProductImages = ["product-1","product-2","product-3","product-4","product-5","product-6","product-7","product-8","product-9"]
    var arrProductName = ["Camera","Tshirt","Lamp","Shoes","Drone","Watch","Top","Creams","Chair"]
    var arrProductPrice = [599.00,59.00,123.00,89.00,1099.95,259.00,75.00,29.00,659.99]
    @IBOutlet weak var collectionProducts: UICollectionView!
    
    
    //MARK: APPLICATION DELEGATE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionProducts.dataSource = self
        collectionProducts.delegate = self
        searchBar.delegate = self
        setUpArrayProduct()
        filterData = arrData
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.collectionProducts.showsVerticalScrollIndicator = false
        setUpMenuButton(isScroll: true)
        self.navigationItem.title = "Shop"
//        self.navigationController?.navigationBar.backgroundColor = .white
        collectionProducts.reloadData()
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            self.collectionProducts?.reloadData()
        }
    }
    
    
    //MARK: SEARCHBAR DELEGATE  METHODS
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.searchBar.showsCancelButton = true
//        searchBar.setImage(UIImage(systemName: "xmark"), for: .clear, state: .normal)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var enteredText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if enteredText != "" {
           
            filterData = arrData.filter {$0.ProductName.lowercased().contains(enteredText.lowercased().trimmingCharacters(in: .whitespaces))

            }
        }else { self.filterData = self.arrData}
        print(filterData,filterData.count)
        collectionProducts.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
    }
    
    
    
    //MARK: COLLECTIONVIEW DELEGATE METHODS
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as! ProductsCollectionViewCell
        print(filterData)
        if filterData.isEmpty {
            
        }
        else{
            cell.imgProduct.image = UIImage(named: filterData[indexPath.row].imageName)
            cell.lblProductName.text =  filterData[indexPath.row].ProductName
            cell.lblPrice.text =  "$ \(filterData[indexPath.row].ProductPrice)"
            cell.lblStrikePrice.isHidden = true
        }
       
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "DetailsScreenVC") as! DetailsScreenVC
        vc.arrCategoryImage.insert(filterData[indexPath.row].imageName, at: 0)
        vc.Price = "\(filterData[indexPath.row].ProductPrice)"
        vc.ProductName = filterData[indexPath.row].ProductName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 5, height: 285)
    }
    
    
    //MARK: USERDEFINED  METHODS
    
    func setUpMenuButton(isScroll : Bool){
        
        let icon = UIImage(named: "setting")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20))
        let iconButton = UIButton(frame: iconSize)
        iconButton.tintColor = UIColor(named: "Custom Black")
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(btnBackClicked), for: .touchUpInside)
        navigationItem.rightBarButtonItem = barButton
        
    }
    
    func setUpArrayProduct(){
        for i in 0...arrProductName.count - 1{
            arrData.append(ProductModel(imageName: arrProductImages[i], ProductName: arrProductName[i], ProductPrice: arrProductPrice[i]))
        }
        
    }
    //MARK: OBJC  METHODS

    @objc func btnBackClicked(){
        let vc = UIStoryboard(name: "ShopStoryboard", bundle: nil).instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        vc.sheetPresentationController?.detents = [.medium()]
//        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
//        let blurEffect = UIBlurEffect(style: .dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(blurEffectView)
//        view.sendSubviewToBack(blurEffectView)
        present(vc,animated:true)
        
        
//        self.navigationController?.pushViewController(vc, animated: true)
    }


}

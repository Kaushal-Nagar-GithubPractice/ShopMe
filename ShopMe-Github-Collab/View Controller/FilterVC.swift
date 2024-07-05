//
//  FilterVC.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 25/06/24.
//

import UIKit
import SwiftRangeSlider

protocol SelectedFilter {
    func onClickApplyFilter(dict : FilterDictModel)
}

class FilterVC: UIViewController {
    @IBOutlet weak var viewPriceRange: UIView!
    @IBOutlet weak var lblMAxPrice: UILabel!
    var arrSize = [""]
    var arrColor = [""]
    @IBOutlet weak var lblMinPrice: UILabel!
    var flagForAppliedFilter = false
    var isSliderSetOnAppear = true
    var dictFilters : FilterDictModel?
    @IBOutlet weak var priceRangeSLider: RangeSlider?
    @IBOutlet weak var collectionColor: UICollectionView!
    @IBOutlet weak var collectionSize: UICollectionView!
    @IBOutlet weak var txtMaxPrice: UITextField!
    @IBOutlet weak var txtMinPrice: UITextField!
    @IBOutlet weak var btnApplyChanges: UIButton!
    @IBOutlet weak var viewSizeBtns: UIView!
    @IBOutlet weak var btnPrice0: UIButton!
    @IBOutlet weak var btnPrice100: UIButton!
    @IBOutlet weak var btnPrice200: UIButton!
    @IBOutlet weak var btnPrice300: UIButton!
    @IBOutlet weak var btnPrice400: UIButton!
    @IBOutlet weak var btnPrice500: UIButton!
    var delegate : SelectedFilter?
    var minPrice = 0
    var maxPrice = 1000
    var SelectedSize = [String]()
    var SelectedColor = [String]()
    var selectedMinPrice = 0
    var selectedMaxPrice = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMenuButton(isScroll: true)
//     "{{URL}}/product/list?minPrice=100&maxPrice=150&color[0]=black&size[0]=9&color[1]=red&size[1]=L"
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        collectionSize.allowsMultipleSelection = true
        collectionColor.allowsMultipleSelection = true
        if isSliderSetOnAppear {
            setUIFilterScreen()
            appliedFilters()
            isSliderSetOnAppear = false
        }
        
    }
    
    //MARK: IBACTION Methods
    
    @IBAction func onClickBtnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func SliderValueChange(_ sender: RangeSlider){
        if sender.lowerValue <= Double(maxPrice - 50) {
            txtMinPrice.text = "\(sender.lowerValue.rounded())"
            selectedMinPrice = Int(sender.lowerValue.rounded())
        }
        if sender.upperValue >= Double(minPrice - 50) {
            txtMaxPrice.text = "\(sender.upperValue.rounded())"
            selectedMaxPrice = Int(sender.upperValue.rounded())
        }
//        txtMaxPrice.text = "\(sender.upperValue)"
    }
    @IBAction func onClickPrice(_ sender: UIButton) {
        btnPrice0.backgroundColor = .systemGray5
        btnPrice100.backgroundColor = .systemGray5
        btnPrice200.backgroundColor = .systemGray5
        btnPrice300.backgroundColor = .systemGray5
        btnPrice400.backgroundColor = .systemGray5
        btnPrice500.backgroundColor = .systemGray5
        if sender.tag  == 6 {
            btnPrice0.backgroundColor = .lightGray
            setSliderOnRange(min: 0, max: 100)
        }
        else if sender.tag  == 7 {
            btnPrice100.backgroundColor = .lightGray
            setSliderOnRange(min: 100, max: 200)
        }
        else if sender.tag  == 8 {
            btnPrice200.backgroundColor = .lightGray
            setSliderOnRange(min: 200, max: 300)
        }
        else if sender.tag  == 9 {
            btnPrice300.backgroundColor = .lightGray
            setSliderOnRange(min: 300, max: 400)
        }
        else if sender.tag  == 10 {
            btnPrice400.backgroundColor = .lightGray
            setSliderOnRange(min: 400, max: 500)
        }
        else if sender.tag  == 11 {
            btnPrice500.backgroundColor = .lightGray
            setSliderOnRange(min: 500, max: Double(maxPrice))
        }
    }
    
    @IBAction func onCLickApplyChanges(_ sender: Any) {
        
       
       lazy var tempMin = 0
       lazy var tempMax = 0
        lazy var tempArrSize = [""]
        lazy var tempArrColor = [""]
            if !(selectedMinPrice <= minPrice) {
                tempMin = selectedMinPrice
            }
             if !(selectedMaxPrice >= maxPrice) {
                 tempMax = selectedMaxPrice
             }
         if !(SelectedSize.isEmpty) {
            tempArrSize = SelectedSize
        }
         if !(SelectedColor.isEmpty) {
            tempArrColor = SelectedColor
        }
        dictFilters = FilterDictModel(minPrice: tempMin, maxPrice: tempMax, size: tempArrSize, color: tempArrColor)
        if SelectedSize == [""] && SelectedColor == [""] && selectedMinPrice == minPrice && selectedMaxPrice == maxPrice {
            ShowAlertBox(Title: "Alert", Message: "No Filter Selected")
        }
        else{
            delegate?.onClickApplyFilter(dict: dictFilters!)
            self.dismiss(animated: true)
        }
        
    }
    //MARK: User Defined Methods
    func setUpMenuButton(isScroll : Bool){
        let icon = UIImage(systemName: "chevron.left")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20))
        let iconButton = UIButton(frame: iconSize)
        iconButton.tintColor = UIColor(named: "Custom Black - h")
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.addTarget(self, action: #selector(btnBackClicked), for: .touchUpInside)
        navigationItem.leftBarButtonItem = barButton
    }
    func setSliderOnRange(min : Double,max : Double){
        priceRangeSLider?.minimumValue = min
        priceRangeSLider?.maximumValue = max
        txtMinPrice.text = "\(min)"
        txtMaxPrice.text = "\(max)"
        selectedMinPrice = Int(min)
        selectedMaxPrice = Int(max)
    }
    
    func appliedFilters(){
        if flagForAppliedFilter {
            priceRangeSLider?.lowerValue = Double(dictFilters?.minPrice ?? minPrice)
            priceRangeSLider?.upperValue = Double(dictFilters?.maxPrice ?? maxPrice)
            SelectedSize = dictFilters?.size ?? []
            SelectedColor = (dictFilters?.color) ?? []
            collectionColor.reloadData()
            collectionSize.reloadData()
            txtMinPrice.text = "\(dictFilters?.minPrice ?? minPrice)"
            txtMaxPrice.text = "\(dictFilters?.maxPrice ?? maxPrice)"
        }
    }
    
    func setUIFilterScreen(){
        priceRangeSLider?.minimumValue = Double(minPrice)
        priceRangeSLider?.maximumValue = Double(maxPrice)
        priceRangeSLider?.lowerValue = Double(minPrice)
        priceRangeSLider?.upperValue = Double(maxPrice)
        txtMinPrice.text = "\(minPrice)"
        txtMaxPrice.text = "\(maxPrice)"
        lblMinPrice.text = "\(minPrice)"
        lblMAxPrice.text = "\(maxPrice)"
    }
    
    
    //MARK: @OBJC Methods
    
    @objc func btnBackClicked(){
        self.dismiss(animated: true)
    }
}

extension FilterVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate {
    
    //MARK: CollectionView Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionSize {
            return arrSize.count
        }else {
            return arrColor.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsCollectionViewCell", for: indexPath) as! ProductDetailsCollectionViewCell
        if collectionView == collectionSize {
            cell.lblChoice.text = arrSize[indexPath.row]
            if flagForAppliedFilter {
                if SelectedSize.contains(cell.lblChoice.text ?? "") {
                    collectionSize.selectItem(at: indexPath, animated: true,
                                              scrollPosition: [])
                    cell.viewChoice.backgroundColor = .systemMint
                }
            }
           
        }else {
            cell.lblChoice.text = arrColor[indexPath.row]
            if flagForAppliedFilter {
                if SelectedColor.contains(cell.lblChoice.text ?? "") {
                    collectionColor.selectItem(at: indexPath, animated: true,
                                              scrollPosition: [])
                    cell.viewChoice.backgroundColor = .systemMint
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionSize {
            return CGSize(width: 45, height: 35)
        }
        else{
            return CGSize(width: 60, height: 35)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = collectionView.cellForItem(at: indexPath) as? ProductDetailsCollectionViewCell
        if collectionView == collectionSize {
                collectionView.selectItem(at: indexPath, animated: true,
                                          scrollPosition: [])
                item?.viewChoice.backgroundColor = .systemMint
                SelectedSize.append(item?.lblChoice.text ?? "")
        }
        else{
                collectionView.selectItem(at: indexPath, animated: true,
                                          scrollPosition: [])
                item?.viewChoice.backgroundColor = .systemMint
                SelectedColor.append(item?.lblChoice.text ?? "")
            }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let item = collectionView.cellForItem(at: indexPath) as? ProductDetailsCollectionViewCell
        if collectionView == collectionSize {
                collectionView.deselectItem(at: indexPath, animated: true)
                item?.viewChoice.backgroundColor = .systemGray5
                SelectedSize.remove(at: SelectedSize.firstIndex(of: item?.lblChoice.text ?? "") ?? -1)
        }
        else{
                collectionView.deselectItem(at: indexPath, animated: true)
                item?.viewChoice.backgroundColor = .systemGray5
                SelectedColor.remove(at: SelectedColor.firstIndex(of: item?.lblChoice.text ?? "") ?? -1)
        }
    }

    //MARK: textfield Delegate Methods
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
            let enteredValue = "\(textField.text ?? "")"+"\(string)"
            let enteredIntValue = (enteredValue as NSString).integerValue
            print(enteredIntValue)
            if textField.tag  == 1 {
                if !(enteredIntValue < minPrice) && !(enteredIntValue > (maxPrice - 50)) {
                    print(Double(enteredIntValue))
                    priceRangeSLider?.lowerValue = Double(enteredIntValue)
                    selectedMinPrice = enteredIntValue
                }
                else{
                    let lastText = (textField.text! as NSString).integerValue
                    priceRangeSLider?.lowerValue = Double(lastText)
                    txtMinPrice.text = textField.text
                    txtMinPrice.resignFirstResponder()
                    selectedMinPrice = lastText
                    return false
                }
            }
            else{
                if !(enteredIntValue < (Int(minPrice) )) && !(enteredIntValue > maxPrice) {
                    priceRangeSLider?.upperValue = Double(enteredIntValue)
                    selectedMaxPrice = enteredIntValue
                }
                else{
                    let lastText = (textField.text! as NSString).integerValue
                    priceRangeSLider?.upperValue = Double(lastText)
                    txtMaxPrice.text = textField.text
                    txtMaxPrice.resignFirstResponder()
                    selectedMaxPrice = lastText
                    return false
                }
            }
        }
        else{
            print(textField.text ?? "")
        }
        return true
    }
}

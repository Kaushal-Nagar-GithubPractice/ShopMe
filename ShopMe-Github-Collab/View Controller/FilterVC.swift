//
//  FilterVC.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 25/06/24.
//

import UIKit

class FilterVC: UIViewController {
    @IBOutlet weak var viewPriceRange: UIView!
    
    @IBOutlet weak var btnApplyChanges: UIButton!
    @IBOutlet weak var viewSizeBtns: UIView!
    @IBOutlet weak var btnPrice0: UIButton!
    @IBOutlet weak var btnPrice100: UIButton!
    @IBOutlet weak var btnPrice200: UIButton!
    @IBOutlet weak var btnPrice300: UIButton!
    @IBOutlet weak var btnPrice400: UIButton!
    @IBOutlet weak var btnPrice500: UIButton!
    @IBOutlet weak var btnSizeXS: UIButton!
    @IBOutlet weak var btnSizeS: UIButton!
    @IBOutlet weak var btnSizeM: UIButton!
    @IBOutlet weak var btnSizeL: UIButton!
    @IBOutlet weak var btnSizeXL: UIButton!
    @IBOutlet weak var heightViewPrice: NSLayoutConstraint!
    @IBOutlet weak var heightViewSize: NSLayoutConstraint!
    @IBOutlet weak var btnPrizeShow: UIButton!
    @IBOutlet weak var btnSizeShow: UIButton!
    var SelectedSize = [Int]()
    var SelectedPrice = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMenuButton(isScroll: true)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setUiFilterScreen()
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: IBACTION Methods
    
    @IBAction func onClickBtnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onClickShowSize(_ sender: Any) {
        if heightViewSize.constant == 0{
            btnSizeShow.setImage(UIImage(systemName: "arrow.up"), for: .normal)
            heightViewSize.constant = 35
            viewSizeBtns.isHidden = false
        }
        else{
            btnSizeShow.setImage(UIImage(systemName: "arrow.down"), for: .normal)
            heightViewSize.constant = 0
            viewSizeBtns.isHidden = true
        }
    }
    @IBAction func onCLickshowPrize(_ sender: Any) {
        if heightViewPrice.constant == 0{
            btnPrizeShow.setImage(UIImage(systemName: "arrow.up"), for: .normal)
            heightViewPrice.constant = 150
        }
        else{
            btnPrizeShow.setImage(UIImage(systemName: "arrow.down"), for: .normal)
            heightViewPrice.constant = 0

        }
    }
    @IBAction func onClickBtnFilterbySize(_ sender: Any) {
        if heightViewSize.constant == 0{
            btnSizeShow.setImage(UIImage(systemName: "arrow.up"), for: .normal)
            heightViewSize.constant = 35
            viewSizeBtns.isHidden = false
        }
        else{
            btnSizeShow.setImage(UIImage(systemName: "arrow.down"), for: .normal)
            heightViewSize.constant = 0
            viewSizeBtns.isHidden = true
        }
    }
    @IBAction func onClickBtnFilterbyPrice(_ sender: Any) {
        if heightViewPrice.constant == 0{
            btnPrizeShow.setImage(UIImage(systemName: "arrow.up"), for: .normal)
            heightViewPrice.constant = 150
        }
        else{
            btnPrizeShow.setImage(UIImage(systemName: "arrow.down"), for: .normal)
            heightViewPrice.constant = 0

        }
    }
    
    @IBAction func onClickSize(_ sender: UIButton) {
        if sender.tag  == 1 {
            if checkSelectedSize(tag: sender.tag) {
                btnSizeXS.backgroundColor = .lightGray
            }
            else{
                btnSizeXS.backgroundColor = .systemGray5
            }
        }
        else if sender.tag  == 2 {
            if checkSelectedSize(tag: sender.tag) {
                btnSizeS.backgroundColor = .lightGray
            }
            else{
                btnSizeS.backgroundColor = .systemGray5
            }
        }
        else if sender.tag  == 3 {
            if checkSelectedSize(tag: sender.tag) {
                btnSizeM.backgroundColor = .lightGray
            }
            else{
                btnSizeM.backgroundColor = .systemGray5
            }
        }
        else if sender.tag  == 4 {
            if checkSelectedSize(tag: sender.tag) {
                btnSizeL.backgroundColor = .lightGray
            }
            else{
                btnSizeL.backgroundColor = .systemGray5
            }
        }
        else if sender.tag  == 5 {
            if checkSelectedSize(tag: sender.tag) {
                btnSizeXL.backgroundColor = .lightGray
            }
            else{
                btnSizeXL.backgroundColor = .systemGray5
            }
        }
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
            SelectedPrice.append(6)
        }
        else if sender.tag  == 7 {
            btnPrice100.backgroundColor = .lightGray
            SelectedPrice.append(7)
        }
        else if sender.tag  == 8 {
            btnPrice200.backgroundColor = .lightGray
            SelectedPrice.append(8)
        }
        else if sender.tag  == 9 {
            btnPrice300.backgroundColor = .lightGray
            SelectedPrice.append(9)
        }
        else if sender.tag  == 10 {
            btnPrice400.backgroundColor = .lightGray
            SelectedPrice.append(10)
        }
        else if sender.tag  == 11 {
            btnPrice500.backgroundColor = .lightGray
            SelectedPrice.append(11)
        }
    }
    
    @IBAction func onCLickApplyChanges(_ sender: Any) {
        if SelectedSize.isEmpty && SelectedPrice.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "No Filter Selected", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
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
    
    func checkSelectedSize(tag: Int) -> Bool{
        if ((SelectedSize.firstIndex(of: tag) != nil) == false){
            SelectedSize.append(tag)
            return true
        }
        else{
            SelectedSize.remove(at: SelectedSize.firstIndex(of: tag) ?? -1)
            return false
        }
    }
    
    func setUiFilterScreen(){
        heightViewPrice.constant = 0
        heightViewSize.constant = 0
        btnSizeL.layer.cornerRadius = 10
        btnSizeM.layer.cornerRadius = 10
        btnSizeS.layer.cornerRadius = 10
        btnSizeXS.layer.cornerRadius = 10
        btnSizeXL.layer.cornerRadius = 10
        btnPrice0.layer.masksToBounds = true
        btnPrice0.layer.cornerRadius = 10
        btnPrice100.layer.masksToBounds = true
        btnPrice100.layer.cornerRadius = 10
        
        btnPrice200.layer.masksToBounds = true
        btnPrice200.layer.cornerRadius = 10
        
        btnPrice300.layer.masksToBounds = true
        btnPrice300.layer.cornerRadius = 10
        btnPrice400.layer.masksToBounds = true
        btnPrice400.layer.cornerRadius = 10
        
        btnPrice500.layer.masksToBounds = true
        btnPrice500.layer.cornerRadius = 10
        viewSizeBtns.isHidden = true
        btnApplyChanges.layer.cornerRadius = 15
    }
    
    //MARK: @OBJC Methods
    
    @objc func btnBackClicked(){
        self.dismiss(animated: true)
    }
}

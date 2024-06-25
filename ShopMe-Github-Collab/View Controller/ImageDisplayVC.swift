//
//  ImageDisplayVC.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit

class ImageDisplayVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionDisplay: UICollectionView!
    var arrImageDisplay = ["product-1","product-2","product-3","product-4","product-5","product-6","product-7","product-8","product-9"]
    var timer : Timer?
    var currentCellIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionDisplay.delegate = self
        collectionDisplay.dataSource = self
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    override func viewWillAppear(_ animated: Bool) {
       
        pageControl.numberOfPages = arrImageDisplay.count
       
        self.navigationController?.isNavigationBarHidden = true
        collectionDisplay.showsHorizontalScrollIndicator = false
    }
    override func viewDidAppear(_ animated: Bool) {
        collectionDisplay.reloadData()
    }
    

    @IBAction func onClickCross(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImageDisplay.count * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHeaderCollectionViewCell", for: indexPath) as! HomeHeaderCollectionViewCell
        cell.imageHeader.image = UIImage(named: arrImageDisplay[indexPath.row % arrImageDisplay.count])
        return cell
    }
    
    
    @objc func slideToNext(){
            currentCellIndex = currentCellIndex + 1
        pageControl.currentPage = currentCellIndex % arrImageDisplay.count
        collectionDisplay.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }
}
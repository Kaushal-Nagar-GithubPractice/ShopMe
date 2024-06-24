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
    var arrImageDisplay = [""]
    var timer : Timer?
    var currentCellIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionDisplay.delegate = self
        collectionDisplay.dataSource = self
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionDisplay.reloadData()
        pageControl.numberOfPages = arrImageDisplay.count
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        self.navigationController?.isNavigationBarHidden = true
    }
    

    @IBAction func onClickCross(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImageDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHeaderCollectionViewCell", for: indexPath) as! HomeHeaderCollectionViewCell
        cell.imageHeader.image = UIImage(named: arrImageDisplay[indexPath.row])
        return cell
    }
    
    
    @objc func slideToNext(){
        if currentCellIndex < arrImageDisplay .count - 1{
            currentCellIndex = currentCellIndex + 1
        }
        else{
            currentCellIndex = 0
        }
        pageControl.currentPage = currentCellIndex
        collectionDisplay.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }
}

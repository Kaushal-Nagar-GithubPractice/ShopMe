//
//  ImageDisplayViewController.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 25/06/24.
//

import UIKit

class ImageDisplayViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionDisplay: UICollectionView!
    var arrImageDisplay = [""]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionDisplay.delegate = self
        collectionDisplay.dataSource = self
        print(collectionDisplay.frame)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionDisplay.reloadData()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false){ _ in
            self.collectionDisplay?.reloadData()
        }
//        self.collectionDisplay.reloadData()
    }

    @IBAction func onClickCross(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return arrImageDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageDisplayCollectionViewCell", for: indexPath) as! ImageDisplayCollectionViewCell
        
        cell.imgView.setImageWithURL(url: arrImageDisplay[indexPath.row], imageView: cell.imgView)
//        cell.viewImage.backgroundColor = .systemGray5
//        cell.viewImage.layer.cornerRadius = 25
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}

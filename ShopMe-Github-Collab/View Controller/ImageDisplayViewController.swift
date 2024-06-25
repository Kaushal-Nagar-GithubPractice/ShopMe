//
//  ImageDisplayViewController.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 25/06/24.
//

import UIKit

class ImageDisplayViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return arrImageDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageDisplayCollectionViewCell", for: indexPath) as! ImageDisplayCollectionViewCell
        cell.imgView.image = UIImage(named: arrImageDisplay[indexPath.row])
        cell.viewImage.backgroundColor = .systemGray5
        cell.viewImage.layer.cornerRadius = 25
        return cell
    }
    
    @IBOutlet weak var collectionDisplay: UICollectionView!
    var arrImageDisplay = [""]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionDisplay.delegate = self
        collectionDisplay.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionDisplay.reloadData()
    }

    @IBAction func onClickCross(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

//
//  SnapVC.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/21/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit

class SnapVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    
    var scrollView : UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "SnapCell", bundle: nil), forCellWithReuseIdentifier: "SnapCell")

        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IDENTIFIERS_SNAP_CELL, for: indexPath) as! SnapCell
        
        cell.username.text = "pdaksh23"
        cell.img.image = #imageLiteral(resourceName: "bg")
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func story(_ sender: Any) {
        
        let scrollPoint = CGPoint(x: 0, y: 0)
        
        self.scrollView.setContentOffset(scrollPoint, animated: true)
    }
    
    @IBAction func chat(_ sender: Any) {
    
//        let scrollPoint = CGPoint(x: self.view.frame.width * 2, y: 0)
//        
//        self.scrollView.setContentOffset(scrollPoint, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //identifier to the perticular viewcontroller
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "newvc")
        self.present(initialViewController, animated: true, completion: nil)
        

    }
    

}

//
//  ChatVC.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/23/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var scrollView : UIScrollView!
    
    //story collection view the top view
    @IBOutlet weak var storyCollectionView: UICollectionView!
    
    //main collection view
    @IBOutlet weak var storyview: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //userview which will pop up via create button
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.storyCollectionView.register(UINib.init(nibName: "ChatStoryViewCell", bundle: nil), forCellWithReuseIdentifier: IDENTIFIERS_CHAT_STORY_CELL)
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self
        storyview.circularControl(cornerRadius: 10.0)
        storyview.layer.borderWidth = 2.0
        storyview.layer.borderColor = UIColor.white.cgColor
        
        
        self.collectionView.register(UINib.init(nibName: "ChatCell", bundle: nil), forCellWithReuseIdentifier: IDENTIFIERS_CHAT_CELL)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
        self.userCollectionView.register(UINib.init(nibName: "UsersCell", bundle: nil), forCellWithReuseIdentifier: IDENTIFIERS_USER_CELL)
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        userCollectionView.isHidden = true
        
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView == self.storyCollectionView {
            return 2
        }
        else if collectionView == self.collectionView {
            return 2
        } else {
            return 21
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView == storyCollectionView {
            
            return CGSize(width: 50, height: 50)
        }else if collectionView == self.collectionView {
            
            return CGSize(width: self.collectionView.frame.width, height: 100.0)
        } else {
            
            return CGSize(width: 100, height: userCollectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.storyCollectionView {
             return storyCollectionView.dequeueReusableCell(withReuseIdentifier: IDENTIFIERS_CHAT_STORY_CELL, for: indexPath) as! ChatStoryViewCell
        }
        else if collectionView == self.collectionView {
            return collectionView.dequeueReusableCell(withReuseIdentifier: IDENTIFIERS_CHAT_CELL, for: indexPath) as! ChatCell
        } else {
            return userCollectionView.dequeueReusableCell(withReuseIdentifier: IDENTIFIERS_USER_CELL, for: indexPath) as! UsersCell
        }
    }

    @IBAction func create(_ sender: Any) {
        
        if userCollectionView.isHidden == true {
            userCollectionView.isHidden = false
        } else {
            userCollectionView.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

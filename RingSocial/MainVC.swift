//
//  MainVC.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/22/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let v1 : Camera = Camera(nibName: "Camera", bundle: nil)
        let v2 : SnapVC = SnapVC(nibName: "SnapVC", bundle: nil)
        let v3 : ChatVC = ChatVC(nibName: "ChatVC", bundle: nil)
        
        self.addChildViewController(v1)
        self.scrollView.addSubview(v1.view)
        v1.didMove(toParentViewController: self)
        
        
        
        self.addChildViewController(v2)
        self.scrollView.addSubview(v2.view)
        v2.didMove(toParentViewController: self)
        v2.scrollView = self.scrollView
        
        //first view controller set on certain point -in this case second view
        var v2Frame : CGRect = v2.view.frame
        v2Frame.origin.x = self.view.frame.width
        v2.view.frame = v2Frame
        
        
        self.addChildViewController(v3)
        self.scrollView.addSubview(v3.view)
        v3.didMove(toParentViewController: self)
        
        var v3Frame : CGRect = v3.view.frame
        v3Frame.origin.x = self.view.frame.width * 2
        v3.view.frame = v3Frame
        v3.scrollView = scrollView
        
        //scrollview size = 3 view controller = 3 frame width, and height frame height
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.view.frame.height)
        
        //scroll view focus on center
        let mainView = CGPoint(x: self.view.frame.width, y: 0)
        self.scrollView.setContentOffset(mainView, animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

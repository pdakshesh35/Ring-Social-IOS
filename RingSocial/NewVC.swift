//
//  NewVC.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/27/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit

class NewVC: UIViewController {
  
    var v : Camera!
    override func viewDidLoad() {
        super.viewDidLoad()
        v = Camera(nibName: "Camera", bundle: nil)
        
        self.addChildViewController(v)
        self.view.addSubview(v.view)
        //v.previewLayer?.frame = self.view.bounds
        
        //self.addChildViewController(v)
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        
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

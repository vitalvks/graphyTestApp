//
//  ProfileViewController.swift
//  graphyApp
//
//  Created by Sudhakar on 02/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userProfileView: UIView!
    @IBOutlet weak var dummyView1: UIView!
    @IBOutlet weak var dummyView2: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.addShadowtoView(viw: userProfileView)
        self.addShadowtoView(viw: dummyView1)
        self.addShadowtoView(viw: dummyView2)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func addShadowtoView(viw: UIView) {
        viw.layer.masksToBounds = false
        viw.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viw.layer.shadowRadius = 5.0
        viw.layer.shadowOpacity = 0.7

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        // Move to center between two top points instead of bottom
        path.addLine(to: CGPoint(x: viw.frame.size.width/2.0, y: viw.frame.size.height/2.0))
        path.addLine(to: CGPoint(x: viw.frame.size.width, y: 0.0))
        path.addLine(to: CGPoint(x: viw.frame.size.width, y: viw.frame.size.height))
        path.addLine(to: CGPoint(x: 0.0, y: viw.frame.size.height))
        path.close()
        viw.layer.shadowPath = path.cgPath
    }

}

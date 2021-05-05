//
//  tabbarVC.swift
//  Traxi
//
//  Created by IOS on 25/03/21.
//

import Foundation
import UIKit

class tabbarVC: UITabBarController {
    //MARK:- Variables
    let ChatScreenTitle = "CHAT"
    let NotificationScreenTitle = "NOTIFICATION"
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor(rgb: 0xFFF6C7)
        
        self.tabBar.tintColor = UIColor(rgb: 0xFF148E)
        //self.tabBar.selectionIndicatorImage = tabBarItem.image?.withRenderingMode(.alwaysTemplate)
        self.delegate = self
    }
}

//MARK:- Extension
extension tabbarVC: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        self.tabBar.tintColor = UIColor(rgb: 0xFF148E)
    }
}

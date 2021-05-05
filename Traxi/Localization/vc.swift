////
////  vc.swift
////  Traxi
////
////  Created by IOS on 24/03/21.
////
//
//import UIKit
//struct myStruct{
//  var lang : String
//  var id : Int
//}
//class languageVC: UIViewController {
//  var languageData = [myStruct(lang: L10n.English.description, id: 0),
//            myStruct(lang: L10n.Hindi.description, id: 1)]
//  var selectedNumber : Int?
//  var img : UIImage?
//  @IBOutlet weak var tableView: UITableView!
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    setUpUI()
//  }
//}
//
////MARK:- Extra Functions
//extension languageVC{
//  @objc func btnActSave(_ sender: UIButton) {
//      L102Language.setAppleLAnguageTo(language[selectedNumber!].code)
//      btnRight.isHidden = true
//      self.navigationController?.popToRootViewController(animated: true)
//      let vc = SplashScreensVC.instantiateFromAppStoryboard(appStoryboard: .Main)
//      let navController = UINavigationController(rootViewController: vc)
//      navController.setNavigationBarHidden(true, animated: false)
//      // Make it a root controller
//      if #available(iOS 13.0, *) {
//        SceneDelegate.shared.window?.rootViewController = navController
//        SceneDelegate.shared.window?.backgroundColor = UIColor.themeColor
//        SceneDelegate.shared.window?.makeKeyAndVisible()
//      } else {
//        AppDelegate.shared().window?.rootViewController = navController
//        AppDelegate.shared().window?.backgroundColor = UIColor.themeColor
//        AppDelegate.shared().window?.makeKeyAndVisible()
//        // Fallback on earlier versions
//   // }
//    }
//  }
//}
//

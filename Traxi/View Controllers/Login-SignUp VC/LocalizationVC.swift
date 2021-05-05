//
//  LocalizationVC.swift
//  Traxi
//
//  Created by IOS on 24/03/21.
//

import UIKit

//MARK:- Structure
struct myStruct{
  var lang : String
  var id : Int
}

class LocalizationVC: UIViewController {
    //MARK:- Variables
    var languageData = [ myStruct(lang: L10n.English.description, id: 0),
                         myStruct(lang: L10n.Hindi.description, id: 1) ]
    var selectedNumber : Int?
    var img : UIImage?
    // MARK: - UI COMPONENTS
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var englishBtn: UIButton!
    @IBOutlet weak var hindiBtn: UIButton!
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
     //   selectedLanguage = language[sender.tag]
    }
    //MARK:- Button Actions
    @IBAction func saveBtnAction(_ sender: UIBarButtonItem) {
        L102Language.setAppleLAnguageTo(language[selectedNumber ?? 0].code)
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func englishBtnAction(_ sender: Any) {
        selectedNumber = 0
        selectedLanguage = language[0]
       // englishBtn.backgroundColor = UIColor.black
    }
    @IBAction func hindiBtnAction(_ sender: Any) {
        selectedNumber = 1
        selectedLanguage = language[1]
       // hindiBtn.backgroundColor = UIColor.black
    }
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK:- Extension
extension LocalizationVC{

}


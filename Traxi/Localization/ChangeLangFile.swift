//
//  ChangeLangFile.swift
//  Traxi
//
//  Created by IOS on 24/03/21.
//

//import Foundation
//var APPLE_LANGUAGE_KEY = "AppleLanguages"
//
//class L102Language {
//
///// get current Apple language
//    class func currentAppleLanguage() -> String{
//        let userdef = UserDefaults.standard
//        var currentWithoutLocale = "Base"
//        if let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as? [String] {
//            if var current = langArray.first {
//                if let range = current.range(of: "-") {
//                    current = String(current[..<range.lowerBound])
//                }
//
//                currentWithoutLocale = current
//            }
//        }
//        return currentWithoutLocale
//    }
//
//    class func currentAppleLanguageFull() -> String{
//        let userdef = UserDefaults.standard
//        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
//        let current = langArray.firstObject as! String
//        return current
//    }
//
//    /// set @lang to be the first in Applelanguages list
//    class func setAppleLAnguageTo(lang: String) {
//        let userdef = UserDefaults.standard
//        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
//        userdef.synchronize()
//    }
//
//    class var isRTL: Bool {
//        return L102Language.currentAppleLanguage() == "hi"
//    }
//
//}
//
//class L012Localizer: NSObject {
//  class func DoTheSwizzling() {
//    // 1
//    MethodSwizzleGivenClassName(Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(key:value:table:)))
//  }
//}
//extension Bundle {
//  @objc func specialLocalizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
//    /*2*/
//    let currentLanguage = L102Language.currentAppleLanguage()
//    var bundle = Bundle();
//    /*3*/
//    if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lpro") {
//      bundle = Bundle(path: _path)!
//    } else {
//      let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
//      bundle = Bundle(path: _path)!
//    }
//    /*4*/
//    return (bundle.specialLocalizedStringForKey(key: key, value: value, table: tableName))
//  }
//}
///// Exchange the implementation of two methods for the same Class
//func MethodSwizzleGivenClassName(_ cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
//  let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
//  let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!;
//  if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
//    class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
//  } else {
//    method_exchangeImplementations(origMethod, overrideMethod);
//  }
//}
import Foundation
var APPLE_LANGUAGE_KEY = "AppleLanguages"
class L102Language {
/// get current Apple language
  class func currentAppleLanguage() -> String{
    let userdef = UserDefaults.standard
    let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
    let current = langArray.firstObject as! String
    return current
  }
/// set @lang to be the first in Applelanguages list
  class func setAppleLAnguageTo(_ lang: String) {
    let userdef = UserDefaults.standard
    userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
    userdef.synchronize()
  }
}
class L012Localizer: NSObject {
  class func DoTheSwizzling() {
    // 1
    MethodSwizzleGivenClassName(Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(key:value:table:)))
  }
}
extension Bundle {
  @objc func specialLocalizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
    /*2*/
    let currentLanguage = L102Language.currentAppleLanguage()
    var bundle = Bundle();
    /*3*/
    if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
      bundle = Bundle(path: _path)!
    } else {
      let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
      bundle = Bundle(path: _path)!
    }
    /*4*/
    return (bundle.specialLocalizedStringForKey(key: key, value: value, table: tableName))
  }
}
/// Exchange the implementation of two methods for the same Class
func MethodSwizzleGivenClassName(_ cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
  let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
  let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!;
  if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
    class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
  } else {
    method_exchangeImplementations(origMethod, overrideMethod);
  }
}

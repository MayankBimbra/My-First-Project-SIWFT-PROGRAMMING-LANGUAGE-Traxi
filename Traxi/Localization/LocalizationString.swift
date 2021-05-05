//
//  HelperFile.swift
//  Traxi
//
//  Created by IOS on 24/03/21.
//

import Foundation

//MARK:- Structure
struct Language {
    var code: String!
    var name: String!
    var id: Int!
    init(_ code: String, name: String, id: Int){
        self.code = code
        self.name = name
        self.id = id
    }
}
//MARK:- Variables
let language : [Language] = [Language.init("en", name: "English",id: 0 ),
                            // Language.init("ar", name: "العربية", id : 1),
                             Language.init("hi", name: "Hindi", id: 2)]

var selectedLanguage : Language = language[0]
//MARK:- Enum
enum L10n {
    // Login Screen
    case Welcomeback
    case PleaseLogInToYourAccount
    case email
    case password
    case forgotPassword
    case signIn
    case becomeaDriver
    case English
    case Hindi
    
    //SignUp Screen
    
    
    
    
    case InternetNotAvailable
}
//MARK:- Extension
extension L10n: CustomStringConvertible{
    
    var description: String{ return self.string }
    
    var string: String{
        switch self {
        case .Welcomeback:
            return L10n.tr("Welcome Back")
        case .PleaseLogInToYourAccount:
            return L10n.tr("Please log in to your account.")
        case .email:
            return L10n.tr("Email or phone number")
        case .password:
            return L10n.tr("Password")
        case .forgotPassword:
            return L10n.tr("Forgot Password?")
        case .signIn:
            return L10n.tr("SIGN IN")
        case .becomeaDriver:
            return L10n.tr("BECOME A DRIVER")
        case .English:
            return L10n.tr("English")
        case .Hindi:
            return L10n.tr("Hindi")
        case .InternetNotAvailable:
            return L10n.tr("Internet Not Available")
        }
    }
    
    private static func tr(_ key: String, _ args: CVarArg...) -> String{
        let format = NSLocalizedString(key, comment: "")
        return format
        //    return String(format: format, locale: Locale.current, arguments: args)
    }
}
//MARK:- Functions
func tr(key: L10n) -> String{
    return key.string
}

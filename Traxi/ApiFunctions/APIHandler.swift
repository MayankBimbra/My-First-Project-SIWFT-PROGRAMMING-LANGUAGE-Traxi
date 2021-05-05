//
//  APIHandler.swift
//  Traxi
//
//  Created by IOS on 24/03/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

enum ApiMethod {
    case GET
    case POST
    case PostWithImage
    case PostWithImages
    case PostString
    case GetString
    case PostWithJSON
    case PUT
    case PUTWithImage
    case DELETE
    case DELETEWithJSON
    case PUTWithJSON
}

class ApiHandler: NSObject {
    static func callApiWithParameters<T:Codable>(url: String , withParameters parameters:[String:Any], ofType : T.Type, success2:@escaping (T)->(), failure: @escaping (Bool, String)->(), method: ApiMethod, img: UIImage? , imageParamater: String, headerPresent: Bool){
        
        //        let configuration = URLSessionConfiguration.default
        //        configuration.timeoutIntervalForRequest = 4
        //        UIApplication.sharePostWithJSONd.isNetworkActivityIndicatorVisible = true
        let manager = Alamofire.SessionManager.default
        //        coredata.shared.getdata()z
        var headers : [String:String] = [:]
        //            "content_type" : "application/json"
        //        ] //["Authorization":coredata.shared.accesstoken]
        
        
        if headerPresent{
            //            headers = ["content_type" : L102Language.currentAppleLanguage()]
            headers = ["Authorization" : coreData.shared.accessToken]
            print(headers)
        }
        
        print("\(appConstantURL().BASE_URL)\(url)")
        print(parameters)
        print(headers)
        
        if !Reachability.isConnectedToNetwork(){
            CommonFunctions.toster(L10n.InternetNotAvailable.description)
            failure(false, "Internet not found")
            return
        }
        
        if method == .GET || method == .POST || method == .PUT || method == .DELETE{
            
            var kMehod = HTTPMethod.get
            
            if method == .POST{
                kMehod = .post
            }else if method == .PUT{
                kMehod = .put
            }else if method == .DELETE{
                kMehod = .delete
            }
            
            manager.request("\(appConstantURL().BASE_URL)\(url)", method : kMehod, parameters:parameters, encoding:URLEncoding.default, headers: headers).responseJSON { response
                in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let statusCode = response.response?.statusCode
                
                do {
                    //                    let result = try doSomething()
                    let kdata = try JSON(data: response.data!)
                    
                    print(kdata)
                    
                    switch response.result{
                    
                    case .success(_):
                        if(statusCode==200){
                            if let data = response.data{
                                do{
                                    let json = try JSONDecoder().decode(T.self, from: data)
                                    success2(json)
                                }
                                catch let error as NSError {
                                    print("Could not save\(error),\(error.userInfo)")
                                }
                            }
                        }
                        else{
                            if statusCode == 500{
                                CommonFunctions.toster("Server Error")
                            }else if let data = response.result.value{
                                let dict=data as! NSDictionary
                                if statusCode == 403{
                                    //                                                CustomLoader.instance.hideLoaderView()
                                    //                                                deleteData()
                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
                                    if navCon != nil{
                                        navCon!.popToRootViewController(animated: true)
                                    }else{
                                        //                                        coredata.shared.deleteProfile()
                                        //                                        let vc = signUpVC.instantiateFromAppStoryboard(appStoryboard: AppStoryboard.Main)
                                        //                                        let navigationController = UINavigationController(rootViewController: vc)
                                        //                                        appDelegate.window?.rootViewController = navigationController
                                        //                                        navigationController.setNavigationBarHidden(true, animated: true)
                                        
                                        
                                        //                                        appDelegate.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                                    }
                                }else if statusCode == 401{
                                    //                                                deleteData()
                                    let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let initialViewController : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                                    let navVC = UINavigationController(rootViewController: initialViewController)
                                    
                                    let alert = UIAlertController(title: "Session expired", message: "Your Session has Expired", preferredStyle: .alert)
                                    let alertAction = UIAlertAction(title: "OK", style: .cancel) { (_) in
                                        coreData.shared.deleteData()
                                        if UIApplication.shared.windows.count > 0 {
                                            UIApplication.shared.windows[0].rootViewController = navVC
                                            navVC.setNavigationBarHidden(true, animated: false)
                                        }
                                    }
                                    alert.addAction(alertAction)
                                    let vc = CommonFunctions.getTopMostViewController()
                                    vc?.present(alert, animated: true, completion: nil)
                                    
                                
                                    
//                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
//                                    if navCon != nil{
//                                        navCon!.popToRootViewController(animated: true)
//                                    }else{
//                                        //                                        coredata.shared.deleteProfile()
//                                        let vc = LoginVC.instantiateFromAppStoryboard(appStoryboard: AppStoryboard.Main)
//                                        let navigationController = UINavigationController(rootViewController: vc)
//                                        UIApplication.shared.keyWindow?.rootViewController = navigationController
//                                        navigationController.setNavigationBarHidden(true, animated: true)
//
//                                    }
                                }else{
                                    if dict.value(forKey: "error_description") != nil{
                                        if let dic = dict.value(forKey: "error_description") as? String {
                                            CommonFunctions.toster(dic)
                                            failure(false, dic)
                                        }
                                    }else{
                                        CommonFunctions.toster(dict.value(forKey: "message") as! String)
                                        failure(false, dict.value(forKey: "message") as! String)
                                    }
                                }
                            }
                        }
                        break
                    case .failure(_):
                        if let error = response.result.error{
                            let str = error.localizedDescription as String
                            CommonFunctions.toster(str)
                            //                            if str.isEqual("Something went wrong. Please try again"){
                            //                                return
                            //                            }
                            
                            failure(false, str)
                        }
                        
                    }
                }
                catch {
                    //                    CommonFunctions.showErrorAlert(message: tr(key: L10n.jsonError))
                    failure(true, "")
                    // Here you know about the error
                    // Feel free to handle to re-throw
                }
                
            }
        }else if method == .PostWithJSON || method == .PUTWithJSON || method == .DELETEWithJSON{
            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            var request = URLRequest(url: URL(string: "\(appConstantURL().BASE_URL)\(url)")!)
            
            if method == .PostWithJSON{
                request.httpMethod = "POST"
            }else if method == .PUTWithJSON{
                request.httpMethod = "PUT"
            }else{
                request.httpMethod = "DELETE"
            }
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.allHTTPHeaderFields = headers
            manager.request(request).responseJSON { response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let statusCode = response.response?.statusCode
                do {
                    //                    let result = try doSomething()
                    let kData = try JSON(data: response.data!)
                    print(kData)
                    if(statusCode==200){
                        if let data = response.data{
                            do{
                                let json = try JSONDecoder().decode(T.self, from: data)
                                success2(json)
                            }
                            catch let error as NSError {
                                print("Could not save\(error),\(error.userInfo)")
                            }
                        }
                    }
                    else{
                        //                            failure(json)
                        if statusCode == 500{
                            CommonFunctions.toster("Server Error")
                        }else if let data = response.result.value{
                            let dict=data as! NSDictionary
                            if statusCode == 403{
                                //  CommonFunctions.hideLoader()
                                //                                            deleteData()
                                //                                let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                //                                navCon.popToRootViewController(animated: true)
                            }else if statusCode == 401{
                                //  CommonFunctions.hideLoader()
                                //                                            deleteData()
                                let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                navCon.popToRootViewController(animated: true)
                            }else{
                                
                                //   CommonFunctions.hideLoader()
                                if dict.value(forKey: "error_description") != nil{
                                    failure(false, dict.value(forKey: "error_description") as! String)
                                    CommonFunctions.toster(dict.value(forKey: "error_description") as! String)
                                }else{
                                    failure(false, dict.value(forKey: "message") as! String)
                                    CommonFunctions.toster(dict.value(forKey: "message") as! String)
                                }
                            }
                        }
                    }
                }
                catch {
                    
                    //                    CommonFunctions.showErrorAlert(message: tr(key: L10n.jsonError))
                    failure(true, "")
                    // Here you know about the error
                    // Feel free to handle to re-throw
                }
                
            }
        }else if method == .GetString || method == .PostString{
            
            var kMehod = HTTPMethod.get
            
            if method == .PostString{
                kMehod = .post
            }
            
            manager.request( "\(appConstantURL().BASE_URL)\(url)", method : kMehod, parameters:parameters,encoding: URLEncoding.default,headers: headers).responseString {
                response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let statusCode = response.response?.statusCode
                
                do {
                    //                    let result = try doSomething()
                    _ = try JSON(data: response.data!)
                    switch response.result{
                    
                    case .success(_):
                        if(statusCode==200){
                            if let data = response.data{
                                do{
                                    let json = try JSONDecoder().decode(T.self, from: data)
                                    success2(json)
                                }
                                catch let error as NSError {
                                    print("Could not save\(error),\(error.userInfo)")
                                }
                            }
                        }
                        else{
                            //                        failure(json)
                            if let data = response.result.value{
                                let dict = data as! NSDictionary
                                if statusCode == 403{
                                    //                                                deleteData()
                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                    navCon.popToRootViewController(animated: true)
                                }else if statusCode == 401{
                                    //                                               deleteData()
                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                    navCon.popToRootViewController(animated: true)
                                }else{
                                    if dict.value(forKey: "error_description") != nil{
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                                            CommonFunctions.toster(dict.value(forKey: "error_description") as! String)
                                        })
                                        
                                        failure(false, dict.value(forKey: "error_description") as! String)
                                    }else{
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                                            CommonFunctions.toster(dict.value(forKey: "message") as! String)
                                        })
                                        
                                        failure(false, dict.value(forKey: "message") as! String)
                                    }
                                }
                            }
                        }
                        break
                        
                    case .failure(_):
                        if let error = response.result.error{
                            let str = error.localizedDescription as String
                            //                        failure(json)
                            failure(false, error.localizedDescription as String)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                                CommonFunctions.toster(str)
                            })
                            
                        }
                    }
                }
                catch {
                    //                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    //                        CommonFunctions.showErrorAlert(message: tr(key: L10n.jsonError))
                    //                    })
                    
                    failure(true, "")
                    // Here you know about the error
                    // Feel free to handle to re-throw
                }
                
                
            }
        }else{
            guard let img = img else{
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                return
            }
            guard let imageData = img.jpegData(compressionQuality: 0.2)else{ //JPEGRepresentation(img, 0.2)else{
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                return
            }
            
            //            let imageData: Data = UIImagePNGRepresentation(img)! as Data
            
            manager.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: imageParamater ,fileName: "file.jpeg", mimeType: "image/jpeg")
                for (key, value) in parameters {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            },
            
            to:"\(appConstantURL().BASE_URL)\(url)", headers:headers)
            { (result) in
                
                switch result {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    upload.responseJSON { response in
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let statusCode = response.response?.statusCode
                        do {
                            //                            let result = try doSomething()
                            let kData = try JSON(data: response.data!)
                            print(kData)
                            if(statusCode==200 || statusCode==201){
                                if let data = response.data{
                                    do{
                                        let json = try JSONDecoder().decode(T.self, from: data)
                                        success2(json)
                                    }
                                    catch let error as NSError {
                                        print("Could not save\(error),\(error.userInfo)")
                                    }
                                }
                            }
                            else{
                                if response.result.isFailure{
                                    failure(false, response.result.error!.localizedDescription)
                                }
                                //                            failure(json)
                                if let data = response.result.value{
                                    let dict=data as! NSDictionary
                                    if statusCode == 403{
                                        //                                        deleteData()
                                        let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                        navCon.popToRootViewController(animated: true)
                                    }else if statusCode == 401{
                                        //                                        deleteData()
                                        coreData.shared.deleteData()
                                        let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                        navCon.popToRootViewController(animated: true)
                                    }else{
                                        if dict.value(forKey: "error_description") != nil{
                                            CommonFunctions.toster(dict.value(forKey: "error_description") as! String)
                                        }else{
                                            CommonFunctions.toster(dict.value(forKey: "message") as! String)
                                        }
                                    }
                                }
                            }
                        }
                        catch {
                            failure(true, "")
                            // Here you know about the error
                            // Feel free to handle to re-throw
                        }
                        
                        
                    }
                    
                case .failure(let encodingError):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    failure(false, encodingError.localizedDescription as String)
                }
            }
        }
    }
}

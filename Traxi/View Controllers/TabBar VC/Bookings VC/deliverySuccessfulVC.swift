//
//  deliverySuccessfulVC.swift
//  Traxi
//
//  Created by mac1 on 28/04/21.
//

import UIKit
import Cosmos

class deliverySuccessfulVC: UIViewController, UITextViewDelegate {
    //MARK:- Variables
//    var packageImage: String?
    //private let startRating:Float = 0.0
    var cosmosRating: Int?
    var success: Bool?
//MARK:- UI Components
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var ratingLblLeftImgView: UIImageView!
    @IBOutlet weak var reviewsLbl: UILabel!
    @IBOutlet weak var rateClientLbl: UILabel!
    @IBOutlet weak var ratingCosmosView: CosmosView!
    @IBOutlet weak var tapToRateClientLbl: UILabel!
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        CommonFunctions.CornerRadius([], textViews: [feedbackTextView], views: [], btns: [submitBtn])
        CommonFunctions.txtViewPadding(feedbackTextView)
        CommonFunctions.btnShadow(submitBtn)
        
        backBtn.addTarget(self, action: #selector(backBtnAction(_:)), for: .touchUpInside)
        submitBtn.addTarget(self, action: #selector(submitBtnAction(_:)), for: .touchUpInside)
        imgView.layer.cornerRadius = imgView.frame.height / 2 - 30
        feedbackTextView.delegate  = self
       // feedbackTextView.text = "Please give your feedback.."
        feedbackTextView.textColor = UIColor.lightGray
        nameLbl.text =  userName!
        reviewsLbl.text = "(" + String(userReviews!) + " reviews)"
        ratingLbl.text =  String(userRated!)
        if user_profile_image != "" {
            self.imgView.yy_setImage(with: URL(string: CommonFunctions.getImage(user_profile_image! , quality: .large)), placeholder: UIImage(named: ""))
        }
        ratingCosmosView.didTouchCosmos = didTouchCosmos
        ratingCosmosView.didFinishTouchingCosmos = didFinishTouchingCosmos
        updateRating()
    }
    func updateRating(){
        cosmosRating = Int((ratingCosmosView.rating))
        print(cosmosRating)
    }
    private class func formatValue(_ value : Double) -> Int{
       return Int(value)
//         String(format: "%.2f", value)
     }
     private func didTouchCosmos(_ rating : Double){
       cosmosRating = deliverySuccessfulVC.formatValue(rating)
     }
     private func didFinishTouchingCosmos(_ rating: Double){
       cosmosRating = deliverySuccessfulVC.formatValue(rating)
     }
    //MARK:- UITextViewDelegate Methods for writing Placeholder text in it
    func textViewDidBeginEditing(_ textView: UITextView) {
        if feedbackTextView.textColor == UIColor.lightGray {
            feedbackTextView.text = nil
            feedbackTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if feedbackTextView.text.isEmpty {
//            feedbackTextView.text = "Please give your feedback.."
            feedbackTextView.textColor = UIColor.lightGray
        }
    }
    //MARK:- Btn Actions
    @objc func backBtnAction(_ sender: UIButton){
        if success == true {
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: tabbarVC.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        } else{
        self.navigationController?.popViewController(animated: true)
        }
    }
    @objc func submitBtnAction(_ sender: UIButton){
        if cosmosRating == 0{
            CommonFunctions.toster("Rate the user First")
        }
        else {
            if feedbackTextView.text! == "" {
                CommonFunctions.toster("Give your Precious Feedback")
            }
            else{
                self.feedbackAPI()
            }
        }
    }
}
 
//MARK:- feedback API
extension deliverySuccessfulVC{
    func feedbackAPI(){
        let params:[String: Any] = [
            "order_id": orderId!,
            "delivery_id": deliverTypeId!,
            "driver_to_user_ratings": cosmosRating!,
            "feedback": self.feedbackTextView.text.trimmingCharacters(in: .whitespacesAndNewlines) 
        ]
        ApiHandler.callApiWithParameters(url: appConstantURL().feedbackUser_DriverURL, withParameters: params, ofType: FeedbackAPI.self, success2: { (response) in
            CommonFunctions.toster(response.message!)
            self.success = true
            self.ratingCosmosView.isUserInteractionEnabled = false
            self.feedbackTextView.isUserInteractionEnabled = false
            self.submitBtn.isUserInteractionEnabled = false
//            for controller in self.navigationController!.viewControllers as Array {
//                if controller.isKind(of: tabbarVC.self) {
//                    self.navigationController!.popToViewController(controller, animated: true)
//                    break
//                }
//            }
        }, failure: { (false, error) in
            print(error)
        }, method: .PUT, img: nil, imageParamater: "", headerPresent: true)
    }
    
}

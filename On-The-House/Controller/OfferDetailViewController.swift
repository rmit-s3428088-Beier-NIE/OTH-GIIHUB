//
//  OfferDetailViewController.swift
//  On-The-House
//
//  Created by beier nie on 18/4/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import UIKit

class OfferDetailViewController: UIViewController {
    
    @IBOutlet weak var WebVideoPlayer: UIWebView!
    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var TicketButton: UIButton!
    @IBOutlet weak var EventImage: UIImageView!
    
    
    @IBOutlet weak var EventDescription: UITextView!
    var offerDetail:OfferModel!
    var videoUrl: URL!
    
    override func viewDidLoad() {
        getTrailer()
        EventImage.image = offerDetail.photo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // to get description without trailer url and get the trailer url
    func getTrailer(){
        var tempStr="" as String
        let pattern = "(?i)https?://(?:www\\.)?\\S+(?:/|\\b)"
        let allMatches = matches(for: pattern, in: offerDetail.description as String)
        
        //play a online video
        if allMatches.count > 0{
            videoUrl = URL(string: allMatches[0])
            let webRequest = URLRequest(url: videoUrl)
            WebVideoPlayer.loadRequest(webRequest)
        }else
        {
            print("Missing Trailer!")
        }
        let splitedArray = offerDetail.description.split(separator: "\r\n")
        for i in splitedArray{
            if i == "Trailer"{
                break
            }else{
                tempStr = tempStr+i
            }
        }
        EventDescription.text  = tempStr
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    // matches video url
    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            let finalResult = results.map {
                String(text[Range($0.range, in: text)!])
            }
            return finalResult
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}


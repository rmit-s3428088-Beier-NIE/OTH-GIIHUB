//
//  OfferModel.swift
//  On-The-House
//
//  Created by beier nie on 22/3/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import Foundation
import CoreData
import UIKit



class OfferModel{
    var name: String
    var photo: UIImage?
    var description: String
    var rate:Int
    
    init(name:String, photo:UIImage, description: String, rate:Int){
        self.name = name
        self.photo = photo
        self.description = description
        self.rate = rate
    }
    
}


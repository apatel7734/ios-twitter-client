//
//  User.swift
//  ios-twitter-client
//
//  Created by Ashish Patel on 9/25/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import Foundation

class User {
    
    init(){
    }
    
    init(dictionary: NSDictionary){
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagLine = dictionary["description"] as? String
    }
    
    var name: String?
    var screenName: String?
    var profileImageUrl: String?
    var tagLine: String?
    
}
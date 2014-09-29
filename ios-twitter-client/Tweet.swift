//
//  Tweet.swift
//  ios-twitter-client
//
//  Created by Ashish Patel on 9/25/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import Foundation

class Tweet{
    
    init(){
        
    }
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        retweetCount = dictionary["retweet_count"] as? Int
        createdAt = dictionary["created_at"] as? String
        
        user = User(dictionary: dictionary["user"] as NSDictionary)
    }
    
    var text: String?
    var retweetCount: Int?
    var retweeted: Bool?
    var createdAt: String?
    var user: User?
    
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for tweetDictionary in array{
            tweets.append(Tweet(dictionary: tweetDictionary))
        }
        
        return tweets
    }
}
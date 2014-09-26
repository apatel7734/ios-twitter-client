//
//  TwitterClient.swift
//  ios-twitter-client
//
//  Created by Ashish Patel on 9/25/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import Foundation

let TWEETER_API_KEY="ZJ19UrjUWj3cwx4XZ15g"
let TWEETER_API_SECRET="6PvCt2CFKbaDWP2LnJxqvUN16re4GBKw7fKRLCkSz8Q"
let TWEETER_TOKEN = "391152948-WEWBmRWUUBwblohQ8XzBtgYj3lI6p5gQtaPNNhrM"
let TWEETER_TOKEN_SECRET = "1sQZeHKD04YjvXwk61QIomaJ34ig9Z3kyuBYtix25U"

let TWEETER_BASE_URL = "https://api.twitter.com/1.1/"
let TWEETER_HOME_TIMELINE_URI = "statuses/home_timeline.json"

class TwitterClient: BDBOAuth1RequestOperationManager{
    
    override init() {
        var baseUrl = NSURL(string: TWEETER_BASE_URL)
        super.init(baseURL: baseUrl, consumerKey: TWEETER_API_KEY, consumerSecret: TWEETER_API_SECRET);
        
        var token = BDBOAuthToken(token: TWEETER_TOKEN, secret: TWEETER_TOKEN_SECRET, expiration: nil)
        println("token = \(token.token)")
        self.requestSerializer.saveAccessToken(token)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //async get hometimeline tweets from API
    func getHomeTimeLineTweets(success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        
        return self.GET(TWEETER_HOME_TIMELINE_URI, parameters: nil, success: success, failure: failure)
    }
    
    
    
    func parseHomeTimeLine(jsonResponseObject: AnyObject!) -> [Tweet]{
        
        var data = NSJSONSerialization.dataWithJSONObject(jsonResponseObject, options: nil, error: nil) as NSData?
        var arrayData = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSArray
        
        var tweets = [Tweet]()
        println("size = \(arrayData.count)")
        for tweet in arrayData{
            var tweetModel = Tweet()
            
            tweetModel.text = tweet.valueForKey("text") as String
            tweetModel.createdAt = tweet.valueForKey("created_at") as String
            var retweeted = tweet.valueForKey("retweeted") as Int
            if(retweeted == 0){
                tweetModel.retweeted = false
            }else {
                tweetModel.retweeted = true
            }
            tweetModel.retweetCount = tweet.valueForKey("retweet_count") as Int

            
            //Add userinfo to tweetobject
            var user = User()
            var userJson = tweet.valueForKey("user") as NSDictionary
            user.name = userJson["name"] as String?
            user.screenName = userJson["screen_name"] as String?
            user.profileImageUrl = userJson.valueForKey("profile_image_url") as String?
            tweetModel.user = user
            
            //add tweet to array
            tweets += [tweetModel]
        }
        return tweets
    }
    
    
    
}

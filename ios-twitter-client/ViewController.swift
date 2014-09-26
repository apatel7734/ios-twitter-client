//
//  ViewController.swift
//  ios-twitter-client
//
//  Created by Ashish Patel on 9/24/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tweetTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tweetTableView.delegate = self
        tweetTableView.dataSource  = self
        
        getHomeTimelineTweets()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("tweetcell") as TweetTableViewCell
        
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func getHomeTimelineTweets() -> [Tweet] {
        var tc = TwitterClient()
        tc.getHomeTimeLineTweets({ (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
           
            var data = NSJSONSerialization.dataWithJSONObject(response, options: nil, error: nil) as NSData?
            var arrayData = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSArray

            var tweets = [Tweet]()
            println("size = \(arrayData.count)")
            for tweet in arrayData{
                var tweetModel = Tweet()
                
                tweetModel.text = tweet.valueForKey("text") as String?
                tweetModel.createdAt = tweet.valueForKey("created_at") as String?
                var retweeted = tweet.valueForKey("retweeted") as Int
                if(retweeted == 0){
                    tweetModel.retweeted = false
                }else {
                    tweetModel.retweeted = true
                }
                tweetModel.retweetCount = tweet.valueForKey("retweet_count") as Int?
                
                //Add userinfo to tweetobject
                var user = User()
                var userJson = tweet.valueForKey("user") as NSDictionary
                user.name = userJson["name"] as String?
                user.screenName = userJson["screen_name"] as String?
                tweetModel.user = user
                
                //add tweet to array
                tweets += [tweetModel]
            }
            
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
        })
        
    }
    
    
}



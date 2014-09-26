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
    
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tweetTableView.delegate = self
        tweetTableView.dataSource  = self
        
        loadHomeTimelineAndRefreshTable()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("tweetcell") as TweetTableViewCell
        var tweet = tweets[indexPath.row]
        
        cell.userNameLabel.text = tweet.user.name
        cell.userIdLabel.text = "@\(tweet.user.screenName)"
        cell.textLabel?.text = tweet.text
        if let imageUrl = tweet.user.profileImageUrl{
            cell.imageView?.setImageWithURL(NSURL(string: tweet.user.profileImageUrl))
        }
        
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func loadHomeTimelineAndRefreshTable(){
        var tc = TwitterClient()
        tc.getHomeTimeLineTweets({ (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.tweets = tc.parseHomeTimeLine(response)
            self.tweetTableView.reloadData()
            
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error : \(error)")
                
        })
    }
    
    
}



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
        
        cell.userNameLabel.text = tweet.user?.name?
        cell.userIdLabel.text = "@\(tweet.user?.screenName?)"
        cell.tweetTextLabel?.text = tweet.text
        cell.tweetImage?.layer.cornerRadius = 8.0
        cell.tweetImage?.clipsToBounds = true
        if let userProfile = tweet.user?.profileImageUrl{
            cell.tweetImage?.setImageWithURL(NSURL(string: userProfile))
        }
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPathRow = tweetTableView.indexPathForSelectedRow()?.row
        if (segue.identifier == "tweetDetailSegue"){
            let selectedTweet = tweets[indexPathRow!]
            let detailTweetVC = segue.destinationViewController as DetailTweetViewController
            
            detailTweetVC.tweet = selectedTweet
        }
    }
    
    func loadHomeTimelineAndRefreshTable(){
        TwitterClient.sharedInstance.getHomeTimeLineWithCompletion { (tweets, error) -> () in
            if let tweets = tweets{
                self.tweets = tweets
                self.tweetTableView.reloadData()
            }
        }
    }
}



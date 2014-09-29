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
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tweetTableView.delegate = self
        tweetTableView.dataSource  = self
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refreshControl.addTarget(self, action: "onRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tweetTableView.addSubview(refreshControl)
    }
    
    func onRefresh(sender: AnyObject){
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        loadHomeTimelineAndRefreshTable()
    }
    
    override func viewWillAppear(animated: Bool) {
        loadHomeTimelineAndRefreshTable()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButtonClicked(sender: AnyObject) {
        
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("tweetcell") as TweetTableViewCell
        var tweet = tweets[indexPath.row]
        
        cell.userNameLabel.text = tweet.user?.name?
        cell.userIdLabel.text = "@\(tweet.user?.screenName?)"
        cell.tweetTextLabel?.text = tweet.text
        cell.tweetImage?.layer.cornerRadius = 8.0
        cell.tweetImage?.clipsToBounds = true
        cell.timestampLabel.text = tweet.timeAgoDate
        
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
            println("tweetDetailSegue clicked")
            let selectedTweet = tweets[indexPathRow!]
            let detailTweetVC = segue.destinationViewController as DetailTweetViewController
            detailTweetVC.tweet = selectedTweet
        }else if(segue.identifier == "createTweetSegue"){
            println("createTweetSegue clicked")
        }
    }
    
    func loadHomeTimelineAndRefreshTable(){
        TwitterClient.sharedInstance.getHomeTimeLineWithCompletion { (tweets, error) -> () in
            if let tweets = tweets{
                self.tweets = tweets
                self.tweetTableView.reloadData()
            }
            
            self.refreshControl.endRefreshing()
        }
    }
}



//
//  DetailTweetViewController.swift
//  ios-twitter-client
//
//  Created by Ashish Patel on 9/28/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

protocol DetailTweetViewControllerDelegate{
    func updateTweet(tweet: Tweet)
}

class DetailTweetViewController: UIViewController {
    
    var tweet = Tweet()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var delegate: DetailTweetViewControllerDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        userNameLabel.text = tweet.user?.name
        screenNameLabel.text = "@\(tweet.user?.screenName)"
        textLabel.text = tweet.text
        timeStampLabel.text = tweet.timeAgoDate
        if let url = tweet.user?.profileImageUrl{
            profileImageView.layer.cornerRadius = 8.0
            profileImageView.clipsToBounds = true
            profileImageView.setImageWithURL(NSURL(string: url))
        }
        
        if let favorited = tweet.favorited{
            updateButtonState(favoriteButton, favorited: favorited)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func replyButtonClicked(sender: AnyObject) {
        println("replyButtonClicked")
    }
    
    
    
    @IBAction func favoriteButtonClicked(sender: UIButton) {
        println("favoriteButtonClicked")
        updateButtonState(sender, favorited: !sender.selected)
    }
    
    func updateButtonState(sender: UIButton, favorited: Bool){
        if(favorited){
            sender.setImage(UIImage(named: "favorite_yellow_on.png"), forState: UIControlState.Normal)
        }else{
            sender.setImage(UIImage(named: "favorite_grey_off.png"), forState: UIControlState.Normal)
        }
        tweet.favorited = favorited
        sender.selected = favorited
        if let del = delegate{
            delegate.updateTweet(tweet)
        }
    }
    
    
    
    @IBAction func retweetButtonClicked(sender: UIButton) {
        println("retweetButtonClicked")
    }
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

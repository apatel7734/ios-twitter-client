//
//  DetailTweetViewController.swift
//  ios-twitter-client
//
//  Created by Ashish Patel on 9/28/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

class DetailTweetViewController: UIViewController {
    
    var tweet = Tweet()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        userNameLabel.text = tweet.user?.name
        screenNameLabel.text = "@\(tweet.user?.screenName)"
        textLabel.text = tweet.text
        if let url = tweet.user?.profileImageUrl{
            profileImageView.layer.cornerRadius = 8.0
            profileImageView.clipsToBounds = true
            profileImageView.setImageWithURL(NSURL(string: url))
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

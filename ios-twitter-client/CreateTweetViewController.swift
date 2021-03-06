//
//  CreateTweetViewController.swift
//  ios-twitter-client
//
//  Created by Ashish Patel on 9/28/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

class CreateTweetViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        profileImageView.layer.cornerRadius = 8.0
        profileImageView.clipsToBounds = true
        
        userNameLabel.text = User.currentUser?.name
        if let userName = User.currentUser?.screenName{
            screenNameLabel.text = "@\(userName)"
        }
        
        if let profileUrl = User.currentUser?.profileImageUrl{
            profileImageView.setImageWithURL(NSURL(string: profileUrl))
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tweetButtonClicked(sender: AnyObject) {
        
        println("Tweet text : \(tweetTextField.text)")
        
        TwitterClient.sharedInstance.tweetStatusWithCompletion({ (tweet, error) -> () in
            if (tweet != nil){
                
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            }, status: tweetTextField.text)
        
    }
    
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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

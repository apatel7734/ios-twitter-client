//
//  TwitterLoginViewController.swift
//  ios-twitter-client
//
//  Created by Ashish Patel on 9/27/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

class TwitterLoginViewController: UIViewController {
    
    @IBOutlet weak var twitterLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        twitterLoginButton.layer.cornerRadius = 5.0
        twitterLoginButton.clipsToBounds = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTwitterLogin(sender: AnyObject) {
        println("Twitter Login Clicked")
        
        TwitterClient.sharedInstance.loginWithCompletion(){
            
            (user: User?, error: NSError?) in
            
            if user != nil{
                //perform segue
                println("login success : \(user?.name)")
                
                self.performSegueWithIdentifier("loginSegue", sender:
                    self)
                
            }else{
                //handle login error
                println("error while login : \(error)")
            }
        }
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

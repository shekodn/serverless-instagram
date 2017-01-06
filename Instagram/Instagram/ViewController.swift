//
//  ViewController.swift
//  Instagram
//
//  Created by Sergio Díaz Navarro on 1/5/17.
//  Copyright © 2017 Sergio Díaz Navarro. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    
    
    
    // The sign-in flow has finished and was successful if |error| is |nil|.
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!){
        
        
        if (error == nil) {
            let idToken = user.authentication.idToken
            let name = user.profile.name
            let email = user.profile.email
            
            print(idToken, name, email)
        } else {
            print("\(error.localizedDescription)")
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().shouldFetchBasicProfile = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


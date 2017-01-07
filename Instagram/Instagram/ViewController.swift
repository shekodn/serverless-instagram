//
//  ViewController.swift
//  Instagram
//
//  Created by Sergio Díaz Navarro on 1/5/17.
//  Copyright © 2017 Sergio Díaz Navarro. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, AWSIdentityProviderManager {
    
    
    var googleIdToken = ""

    
    // The sign-in flow has finished and was successful if |error| is |nil|.
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!){
        
        
        
        if (error == nil) {
            googleIdToken = user.authentication.idToken
            //let name = user.profile.name
            //let email = user.profile.email
            
            signInToCognito(user: user)
        
            //print(idToken, name, email)
        } else {
            print("\(error.localizedDescription)")
        }
        
    }
    
    

    
    func logins() -> AWSTask<NSDictionary>{
        
        let result = NSDictionary(dictionary: [AWSIdentityProviderGoogle: googleIdToken])
        return AWSTask(result: result)
    }
    
    
    
     func signInToCognito(user: GIDGoogleUser){
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .usEast1, identityPoolId: "us-east-1:a72964a4-5bbb-41ae-b2f1-21763d6027d2", identityProviderManager: self)
        
        let configuration = AWSServiceConfiguration(region: .usEast1, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        credentialsProvider.getIdentityId().continue(  {(task:AWSTask) -> AnyObject? in
            
            if task.error == nil {
              
                let syncClient = AWSCognito.default()
                let dataset = syncClient?.openOrCreateDataset("instagramDataSet")
                dataset?.setString(user.profile.email, forKey: "email")
                dataset?.setString(user.profile.name, forKey: "name")
                
                let result = dataset?.synchronize()
                
                print("Data set was synched" + "\n")
                
                result?.continue({ (task:AWSTask) -> AnyObject? in
                    if task.error != nil {
                        print(task.error)
                    } else {
                        print(task.result)
                    }
                    
                    return nil
                })

                return nil
            }
            
            if (task.error != nil) {
                print(task.error)
                return nil
            }

            return nil
        })
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


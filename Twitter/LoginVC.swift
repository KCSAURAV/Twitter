//
//  LoginVC.swift
//  Twitter
//
//  Created by SAURAV on 3/10/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  override func viewDidAppear(_ animated: Bool) {
    if(UserDefaults.standard.bool(forKey: "UserLoggedin") == true){
      self.performSegue(withIdentifier: "loginToHome", sender: self)
    }
  }
  @IBAction func onLoginButton(_ sender: Any) {
    let myUrl = "https://api.twitter.com/oauth/request_token"
    TwitterAPICaller.client?.login(url: myUrl, success: {
      UserDefaults.standard.set(true, forKey: "UserLoggedin")
      self.performSegue(withIdentifier: "loginToHome", sender: self)
    }, failure: { (Error) in
      print("Could not login")
    })
  }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  HomeTableVC.swift
//  Twitter
//
//  Created by SAURAV on 3/10/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableVC: UITableViewController {

  var tweetArr = [NSDictionary]()
  var numTweets: Int!

  let refControl = UIRefreshControl()
  override func viewDidLoad() {
    super.viewDidLoad()
    loadTweets()
    refControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
    tableView.refreshControl = refControl
  }
  
  @objc func loadTweets(){ // calls API
    let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
    numTweets = 10
    let myParams = ["count": numTweets]
    
    TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: {
      (tweets: [NSDictionary]) in
      self.tweetArr.removeAll()
      for tweet in tweets{
        self.tweetArr.append(tweet)
      }
      
      self.tableView.reloadData()
      self.refControl.endRefreshing()
    }, failure: { (Error) in
      print("Could not retrieve tweets")
    })
  }

  func loadMoreTweets(){ // infinite scrolling function
    let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
    
    numTweets = numTweets + 10
    let myParams = ["count": numTweets]
    
    
    TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: {
      (tweets: [NSDictionary]) in
      self.tweetArr.removeAll()
      for tweet in tweets{
        self.tweetArr.append(tweet)
      }
      
      self.tableView.reloadData()
//      self.refControl.endRefreshing() // not needed here
    }, failure: { (Error) in
      print("Could not retrieve tweets")
    })
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row + 1 == tweetArr.count{
      loadMoreTweets()
    }
  }
  
  @IBAction func onLogout(_ sender: Any) {
    TwitterAPICaller.client?.logout()
    self.dismiss(animated: true, completion: nil)
    UserDefaults.standard.set(false, forKey: "UserLoggedin")
  }
  // MARK: - Table view data source

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetsCell
    
    let user = tweetArr[indexPath.row]["user"] as! NSDictionary
    
    cell.userName.text = user["name"] as? String
    cell.tweet.text = tweetArr[indexPath.row]["text"] as? String
    
    let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
    let data = try? Data(contentsOf: imageURL!)
    
    if let imageData = data {
      cell.profileImg.image = UIImage(data: imageData)
    }
    
    // Set up Table
    tableView.delegate = self
    tableView.dataSource = self
    
    return cell
  }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArr.count
    }
}

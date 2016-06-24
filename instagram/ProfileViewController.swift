//
//  ProfileViewController.swift
//  instagram
//
//  Created by Olivia Koshy on 6/22/16.
//  Copyright © 2016 Olivia Koshy. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    var posts = [PFObject]()
    var username = PFUser.currentUser()?.username
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchUserPosts()
        //var username = PFUser.currentUser()?.username
        
        
        
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
        
    
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("profileCell", forIndexPath: indexPath) as! profileCollectionCell
    
        let post = posts[indexPath.row]
        let parsedImage = post["media"] as? PFFile
        
        cell.profileImage.file = parsedImage

        cell.profileImage.loadInBackground()
        
        flowLayout.scrollDirection = .Horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        

        
      
        return cell
   
    }
    
    func fetchUserPosts() {
        
        // Define Query Parameters
        let query = PFQuery(className: "Post")
    
        query.whereKey("author", equalTo: (PFUser.currentUser()!))
        print(username)
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        //Fire off the network request
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                // do something with the data fetched
                self.posts = posts
                self.usernameLabel.text = self.username
                
                self.collectionView.reloadData()
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

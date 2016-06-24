//
//  imageDetailsViewController.swift
//  instagram
//
//  Created by Olivia Koshy on 6/21/16.
//  Copyright © 2016 Olivia Koshy. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class imageDetailsViewController: UIViewController {
    
    @IBOutlet weak var timeStampLabel: UILabel!

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var photoView: PFImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var likeCount: UILabel!
   
    @IBOutlet weak var bottomUsernameLabel: UILabel!
    
    
    var post : PFObject!
    var username : String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photo = self.post["media"] as? PFFile
        let timestamp = post.createdAt! as NSDate
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
       
        self.timeStampLabel.text  = formatter.stringFromDate(timestamp)
        
        self.photoView.file = photo!
        self.captionLabel.text = self.post["caption"] as! String
        self.photoView.loadInBackground()
        self.usernameLabel.text = self.post["author"].username
        self.bottomUsernameLabel.text = self.usernameLabel.text
        self.likeCount.text = "\(post["likesCount"])"
        
        
    
        
        //self.timeStampLabel.text = timestamp
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
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

//
//  postCellTableViewCell.swift
//  instagram
//
//  Created by Olivia Koshy on 6/21/16.
//  Copyright © 2016 Olivia Koshy. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class postCellTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var usernamePostLabel: UILabel!
   
    @IBOutlet weak var caption: UILabel!

    @IBOutlet weak var timeStamp: UILabel!
    
    @IBOutlet weak var photoView: PFImageView!

    @IBOutlet weak var likeCountLabel: UILabel!
    
  
    var query = PFQuery(className: "Post")
    var objID = ""
    var currentCount = 0
    
//    var instagramPost: PFObject! {
//        didSet {
//            self.photoView.file = instagramPost["image"] as? PFFile
//            self.photoView.loadInBackground()
//        }
//    }

    @IBAction func likeButton(sender: AnyObject) {
        currentCount += 1
        var query = PFQuery(className: "Post")
        query.getObjectInBackgroundWithId(objID) {
            (object, error) -> Void in
            if error != nil {
                
            }else {
                object!["likesCount"] = self.currentCount as Int
                self.likeCountLabel.text = "\(self.currentCount)"
                print(object!["caption"])
                object!.saveInBackground()
                
            }
            
            
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        query.getObjectInBackgroundWithId("4Qwr0oFo7a") {
            (post: PFObject?, error: NSError?) -> Void in
            
            if error == nil {
                
            }
        }

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

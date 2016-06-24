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

    var query = PFQuery(className: "Post")
//    var instagramPost: PFObject! {
//        didSet {
//            self.photoView.file = instagramPost["image"] as? PFFile
//            self.photoView.loadInBackground()
//        }
//    }

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

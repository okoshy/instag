//
//  ImagePickerController.swift
//  instagram
//
//  Created by Olivia Koshy on 6/20/16.
//  Copyright © 2016 Olivia Koshy. All rights reserved.
//

import UIKit
import MBProgressHUD

class ImagePickerController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var captionText: UITextField!
    let imagePicker = UIImagePickerController()
   
    @IBAction func publishAction(sender: AnyObject) {
        
        Post.postUserImage(imageView.image , withCaption: captionText.text) {(success: Bool, error: NSError?) in
            
            if error == nil {
                print("data uploaded, prepare for Sugue")
                
                //self.performSegueWithIdentifier("publishPost", sender: self)
             
                self.tabBarController?.selectedIndex = 0
            
            }else {
                print("Something went wrong uploading")
                print(error)
            }
            
        }
    //tabBarController?.selectedIndex = 0
    }
    
    
    @IBAction func uploadImageAction(sender: AnyObject) {
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        imageView.contentMode = .ScaleAspectFit
        imageView.image = editedImage
        
        
        
        
    
        
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
    }


    
     //MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("switching views")
        let homeViewController = segue.destinationViewController as! HomeViewController
        
    }
    

}


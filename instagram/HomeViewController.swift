//
//  HomeViewController.swift
//  instagram
//
//  Created by Olivia Koshy on 6/20/16.
//  Copyright © 2016 Olivia Koshy. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import MBProgressHUD

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var posts = [PFObject]()
    var refreshControl = UIRefreshControl()
    var isMoreLoading = false
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    static let defaultHeight:CGFloat = 60.0
    var loadingMoreView: InfiniteScrollActivityView?
    var username = PFUser.currentUser()!.username
    
    
  
    
    @IBAction func onSignOut(sender: AnyObject) {
        print("Signing Out")
        // PFUser.logOutInBackgroundWithBlock { (error: NSError?) in
        self.performSegueWithIdentifier("logoutSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(username!)
        tableView.delegate = self
        tableView.dataSource = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.hidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        tableView.contentInset = insets
        loadMoreData()
        
        //NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    ?
    func refreshControlAction(refreshControl: UIRefreshControl) {
        print("refresh control action")
        loadMoreData()
        
        // ... Use the new data to update the data source ...
        
        // Reload the tableView now that there is new data
        
        
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! postCellTableViewCell
       
        
       
        
        // fetch data asynchronousl
                let post = posts[indexPath.row]
                print(post)
        
                let parsedImage = post["media"] as? PFFile
        
                let parsedCaption = post["caption"]
        
        
                cell.photoView.file = parsedImage
                cell.caption.text = parsedCaption.description
                cell.photoView.loadInBackground()
                cell.usernamePostLabel.text = username
        cell.likeCountLabel.text =  "\(post["likesCount"])"
        cell.objID = post.objectId!
        cell.currentCount = post["likesCount"] as! Int
        
        let timestamp = post.createdAt! as NSDate
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        cell.timeStamp.text  = formatter.stringFromDate(timestamp)
                print(username)
        
                
        

        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Handle scroll behavior here
        
        if (!isMoreLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                
                isMoreLoading = true
                let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                print("Animating")
                
                print("loading more data")
                loadMoreData()
                
                // ... Code to load more results ...
            }
        }
    }
    
    func fetchPosts() {
        
        // Define Query Parameters
        let query = PFQuery(className: "Post")
        print("fetching post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 2
        query.skip = self.posts.count
        
        
        
        //Fire off the network request
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                print("fire off network request")
                self.loadingMoreView!.stopAnimating()
                // do something with the data fetched
                self.posts.appendContentsOf(posts)
                print (posts)
               
                
                }
            
        }
        
    }
    
    func loadMoreData() {
        
        fetchPosts()
        print("Load more data")
        self.isMoreLoading = false
        //self.loadingMoreView!.stopAnimating()
        
        self.tableView.reloadData()
        
        
    }
    
    func onTimer() {
        fetchPosts()
    }
    
    
    
        
        
        
        
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if( segue.identifier == "imageDetailSegue"){
            print("Prepare for Segues")
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let post = posts[indexPath!.row]
            print (post)
            print("collection view")
            let detailViewController = segue.destinationViewController as! imageDetailsViewController
        
            detailViewController.post = post
        }
        if(segue.identifier == "logoutSegue") {
            print("logging out")
        }
        
        
        
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
    }
    
    
}


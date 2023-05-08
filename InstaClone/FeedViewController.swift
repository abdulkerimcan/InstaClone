//
//  FeedViewController.swift
//  InstaClone
//
//  Created by Abdulkerim Can on 7.05.2023.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tview: UITableView!
    var postList = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tview.dataSource = self
        tview.delegate = self
        getData()
    }
    
    func getData() {
        let db = Firestore.firestore()
        
        db.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            print("girdi")
            if error != nil {
                
            }else {
                
                if snapshot?.isEmpty != true {
                    self.postList.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        let post = Post()
                        if let date = document.get("date") as? String{
                            post.date = date
                        }
                        if let postedBy = document.get("postedBy") as? String {
                            post.postedBy = postedBy
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            post.imageUrl = imageUrl
                        }
                        if let postComment = document.get("postComment") as? String {
                            post.postComment = postComment
                        }
                        if let likes = document.get("likes") as? Int {
                            post.likes = likes
                        }
                        
                        self.postList.append(post)
                    }
                    self.tview.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let post = postList[indexPath.row]
        cell.userEmailText.text = post.postedBy
        cell.descriptionText.text = post.postComment
        cell.likesText.text = "\(post.likes!)"
        cell.postImage.sd_setImage(with: URL(string: post.imageUrl!))
        
        
        return cell
    }
    
}

//
//  UploadViewController.swift
//  InstaClone
//
//  Created by Abdulkerim Can on 7.05.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

class UploadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descText: UITextField!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
    }
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true,completion: nil)
    }
    
    @IBAction func uploadClick(_ sender: Any) {
        let storage = Storage.storage()
        let reference = storage.reference()
        
        let mediaFolder = reference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data,metadata: nil) { metadata, error in
                if error != nil {
                    self.showAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    imageReference.downloadURL { url, error in
                        if error != nil {
                            self.showAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                        }else {
                            let imgUrl = url?.absoluteString
                            
                            let db = Firestore.firestore()
                            
                            var ref : DocumentReference? = nil
                            
                            var firestorePost = ["imageUrl": imgUrl,"postedBy" : Auth.auth().currentUser?.email,"postComment" : self.descText.text!,"date":FieldValue.serverTimestamp(),"likes":0] as [String: Any]
                            
                            ref = db.collection("Posts").addDocument(data: firestorePost,completion: { error in
                                if error != nil {
                                    self.showAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                } else {
                                    self.imageView.image = UIImage(named: "select")
                                    self.descText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
    func showAlert(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ok", style: .default,handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true,completion: nil)
    }
}

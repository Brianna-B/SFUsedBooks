//
//  CreatePostingViewController.swift
//  UserLoginAndRegistration
//
//  Created by Waez Dewan on 11/3/16.
//  Copyright © 2016 Layomi Dele-Dare. All rights reserved.
//

import UIKit

class CreatePostingViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // these are from the text fields
    @IBOutlet weak var course_department: UITextField!
    @IBOutlet weak var course_number: UITextField!
    @IBOutlet weak var book_title: UITextField!
    @IBOutlet weak var book_edition: UITextField!
    @IBOutlet weak var book_author: UITextField!
    @IBOutlet weak var book_isbn: UITextField!
    @IBOutlet weak var book_price: UITextField!
    @IBOutlet weak var book_quality: UITextField!
    
    // these are from the table view controller
    var courseDepartment: String?
    var courseNumber: String?
    var bookTitle: String?
    var bookEdition: String?
    var bookAuthor: String?
    var bookISBN: String?
    var bookPrice: String?
    var bookQuality: String?
    
    // camera
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    var imagechange = 0
    
    @IBOutlet weak var currentTextbookButton: UIButton!
    @IBOutlet weak var createPostButton: UIButton!
    
    @IBAction func changeImageButton1(sender: AnyObject) {
        imagechange = 1
        importPhoto()
    }
    
    @IBAction func changeImageButton2(sender: AnyObject) {
        imagechange = 2
        importPhoto()
    }
    
    @IBAction func changeImageButton3(sender: AnyObject) {
        imagechange = 3
        importPhoto()
    }
    
    @IBAction func changeImageButton4(sender: AnyObject) {
        imagechange = 4
        importPhoto()
    }
    
    /*@IBAction func takePhoto(sender: AnyObject) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
    presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func importPhoto(sender: AnyObject) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    imageView.image = image
    self.dismissViewControllerAnimated(true, completion: nil)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Posting"
        imageView1.layer.borderWidth = 1
        imageView2.layer.borderWidth = 1
        imageView3.layer.borderWidth = 1
        imageView4.layer.borderWidth = 1
        
        currentTextbookButton.tag = 1
        createPostButton.tag = 2
    }
    
    func importPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        if imagechange == 1 {
            imageView1.image = image
        } else if imagechange == 2 {
            if imageView1.image == nil {
                imageView1.image = image
            } else {
                imageView2.image = image
            }
        } else if imagechange == 3 {
            if imageView1.image == nil {
                imageView1.image = image
            } else if imageView2.image == nil {
                imageView2.image = image
            } else {
                imageView3.image = image
            }
        } else if imagechange == 4 {
            if imageView1.image == nil {
                imageView1.image = image
            } else if imageView2.image == nil {
                imageView2.image = image
            } else if imageView3.image == nil {
                imageView3.image = image
            } else {
                imageView4.image = image
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let department = courseDepartment {
            course_department.text = department
        }
        if let number = courseNumber {
            course_number.text = number
        }
        if let title = bookTitle {
            book_title.text = title
        }
        if let edition = bookEdition {
            book_edition.text = edition
        }
        if let author = bookAuthor {
            book_author.text = author
        }
        if let isbn = bookISBN {
            book_isbn.text = isbn
        }
        if let price = bookPrice {
            book_price.text = price
        }
        if let quality = bookQuality {
            book_quality.text = quality
        }
    }
    
    @IBAction func createPostButtonAction(sender: AnyObject) {
        
        if(course_department.text!.isEmpty || course_number.text!.isEmpty || book_title.text!.isEmpty||book_edition.text!.isEmpty || book_author.text!.isEmpty || book_isbn.text!.isEmpty||book_price.text!.isEmpty || book_quality.text!.isEmpty)
        {
            displayMyAlertMessage("All fields are required")
        }
        else if(imageView1.image == nil)
        {
            displayMyAlertMessage("At least, one image of your textbook is needed")
            
        }
    }
    
    func displayMyAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        let okAction = UIAlertAction(title:"Ok", style: UIAlertActionStyle.Default, handler:nil);
        
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated:true, completion:nil);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender!.tag == 2 {
            let destViewController: ConfirmPostViewController = segue.destinationViewController as! ConfirmPostViewController
            
            destViewController.courseDepartment = course_department.text
            destViewController.courseNumber = course_number.text
            destViewController.bookTitle = book_title.text
            destViewController.bookEdition = book_edition.text
            destViewController.bookAuthor = book_author.text
            destViewController.bookISBN = book_isbn.text
            destViewController.bookPrice = book_price.text
            destViewController.bookQuality = book_quality.text
            
            destViewController.imageView1 = imageView1.image
            destViewController.imageView2 = imageView2.image
            destViewController.imageView3 = imageView3.image
            destViewController.imageView4 = imageView4.image
            
        }
    }
    
}

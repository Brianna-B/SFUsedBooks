//
//  RegisterPageViewController.swift
//  UserLoginAndRegistration
//
//  Created by Layomi Dele-Dare on 11/1/16.
//  Copyright © 2016 Layomi Dele-Dare. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterPageViewController: UIViewController {
    
    var ref: FIRDatabaseReference!
    
    
    var checkedBox = UIImage(named: "checking-square")
    var uncheckedBox = UIImage(named: "checkbox")
    
    var isBoxChecked: Bool!
    
    
        
    isBoxChecked = false

    @IBOutlet weak var UserEmailTextField: UITextField!
    @IBOutlet weak var UserPasswordTextField: UITextField!
    @IBOutlet weak var UserIdTextField: UITextField!
    @IBOutlet weak var VerifyPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create New Account"
        ref = FIRDatabase.database().reference()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SignUpButtonTapped(sender: AnyObject) {
        
        let userEmail = UserEmailTextField.text;
        let userPassword = UserPasswordTextField.text;
        let userId = UserIdTextField.text;
        let userVerifyPassword = VerifyPasswordTextField.text;
        
        FIRAuth.auth()?.createUserWithEmail(UserEmailTextField.text!, password: UserPasswordTextField.text!, completion: { (user, error)
            in
            if error != nil{
                print(error)
                return
            }
            
            let userID: String = user!.uid
            let userEmail: String = self.UserEmailTextField.text!
            let userPassword: String = self.UserPasswordTextField.text!
            
            self.ref.child("Users").child(userID).setValue(["Email": userEmail, "UserId": userID, "Password": userPassword])
            
        })
    
    
        //check for empty fields
        if(userEmail!.isEmpty || userId!.isEmpty || userPassword!.isEmpty || userVerifyPassword!
            .isEmpty)
        {
            //Display alert message
            
            displayMyAlertMessage("All fields are required");
            return;
        }
        
        let isEmailAddressValid = isValidEmailAddress(userEmail!)
        
        if (!isEmailAddressValid)
        {
            print("Email Address is not valid");
            displayMyAlertMessage("Email address is not valid");
        }
        
        
        //check if passwords match
        if(userPassword != userVerifyPassword)
        {
            //Display an alert message
            displayMyAlertMessage("Passwords do not match");
            return;
        }
        
        if(isBoxChecked == false)
        {
            displayMyAlertMessage("Please check the box after reading Terms & Condtions")
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            
            //Display alert with confirmation
            
            let myAlert = UIAlertController(title:"Alert", message:"Registration is successful. Thank you!", preferredStyle:  UIAlertControllerStyle.Alert);
            
            let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.Default){ action in
                self.dismissViewControllerAnimated(true, completion:nil);
            }
            myAlert.addAction(okAction);
            self.presentViewController(myAlert, animated: true, completion:nil)
        
        });
    
    }


    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        // print("validate calendar: \(testStr)")
        //let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[sfu]+\\.[ca]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(emailAddressString)
}
    
        func displayMyAlertMessage(userMessage:String)
        {
            let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
            let okAction = UIAlertAction(title:"OK", style: UIAlertActionStyle.Default, handler:nil);
            
            myAlert.addAction(okAction);
            self.presentViewController(myAlert, animated:true, completion:nil);
            
        }
        @IBAction func checkboxButtonChecked(sender: AnyObject) {
            if (isBoxChecked == true) {
                isBoxChecked = false
                checkbox.setImage(uncheckedBox, forState: UIControlState.Normal)
            }
            else {
                isBoxChecked = true
                checkbox.setImage(checkedBox, forState: UIControlState.Normal)
            }
            
            /* if (isBoxChecked == true){
            checkbox.setImage(checkedBox, forState: UIControlState.Normal)
            }
            else{
            checkbox.setImage(uncheckedBox, forState: UIControlState.Normal)
            }*/
        }

}



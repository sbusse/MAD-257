//
//  SignUpViewController.swift
//  MiniApp-FirebaseAuth-v4
//
//  Created by student on 9/23/20.
//  Copyright © 2020 MAD 257. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements() {
        
        //hide the error label
        errorLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
    }
    //check the fields and validate the data is correct.  If correct, this method returns nil.  Otherwise, it returns the error message as a a
    func validateFields() -> String? {
        
        //check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        //check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        
        
            return nil
    }

    
    @IBAction func signUpTapped(_ sender: Any) {
        
        //validate the fiels
        let error = validateFields()
        
        if error != nil {
            
            //there's something wrong with the fiels, show error message
            showError(error!)
        } else {
            
            //create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                //check for erros
                if err != nil {
                    
                    //there was an error creating the user
                    self.showError("Error creating user")
                    
                } else {

                    
                    //user was created successfull, now store the first and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                            //show error message
                            self.showError("ERROR saving user data")
                        }
                    }
                    
                    // Trasition to the home screen
                    self.transitionToHome()
                    
                }
            }
            
            //transition to the home screen
            
        }

    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }

}

//
//  ogretmengirisVC.swift
//  studentSystem
//
//  Created by Olgun ‏‏‎‏‏‎ on 8.02.2024.
//

import UIKit
import Firebase
import FirebaseAuth
import LocalAuthentication
class ogretmengirisVC: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func fastClicked(_ sender: Any) {
        let authContext = LAContext()
        var error: NSError?
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authentication") { (success, error) in
                DispatchQueue.main.async {
                    if success {
                        self.performSegue(withIdentifier: "togirisVC", sender: nil)
                    } else {
                        self.makeAlert(title: "Error", message: "Biometric authentication failed. Please try again.")
                    }
                }
            }
        }

    }
    

    @IBAction func signinClicked(_ sender: Any) {
       
            
            
            
            if emailText.text != "" && passwordText.text != "" {
                Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                    if error != nil {
                        self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                        
                    }
                    else {
                        self.performSegue(withIdentifier: "togirisVC", sender: nil)
                    }
                }
            }
            else {
                self.makeAlert(title: "Error", message: "Username ? / Password ?")
            }
        
        
        
    }
    func makeAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    
}

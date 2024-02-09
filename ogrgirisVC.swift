import UIKit
import Firebase
import FirebaseAuth
import LocalAuthentication

class ogrgirisVC: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func fastSign(_ sender: Any) {
        let authContext = LAContext()
        var error: NSError?
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authentication") { (success, error) in
                DispatchQueue.main.async {
                    if success {
                        self.performSegue(withIdentifier: "ogrgirisVC", sender: nil)
                    } else {
                        self.makeAlert(title: "Error", message: "Biometric authentication failed. Please try again.")
                    }
                }
            }
        }
    }
    
    @IBAction func signinClicked(_ sender: Any) {
        guard let email = emailText.text, let password = passwordText.text, !email.isEmpty, !password.isEmpty else {
            makeAlert(title: "Error", message: "Please enter both email and password.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authdata, error in
            if let error = error {
                self.makeAlert(title: "Error", message: error.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "ogrgirisVC", sender: nil)
            }
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

//
//  ogretmenanaVC.swift
//  studentSystem
//
//  Created by Olgun ‏‏‎‏‏‎ on 8.02.2024.
//

import UIKit
import Firebase
import FirebaseAuth
class ogretmenanaVC: UIViewController {

    @IBOutlet weak var adLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userEmail = Auth.auth().currentUser?.email {
            self.adLabel.text = userEmail
        }

    }
    
    @IBAction func notgirClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "notgirVC", sender: nil)
        
        
    }
    
    @IBAction func yoklamabaslatClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "yoklamabaslatVC", sender: nil)
    }
    @IBAction func duyurularClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "duyuruVC", sender: nil)
    }
    
    @IBAction func istekClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "istekVC", sender: nil)
    }
    
    @IBAction func signoutClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "cikisVC", sender: nil)
    }
    
}

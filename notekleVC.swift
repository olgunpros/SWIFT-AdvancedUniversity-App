//
//  notekleVC.swift
//  studentSystem
//
//  Created by Olgun ‏‏‎‏‏‎ on 8.02.2024.
//

import UIKit
import Firebase
import FirebaseFirestore
class notekleVC: UIViewController {

    @IBOutlet weak var notField: UITextField!
    @IBOutlet weak var dersadiField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
    }
    
   
    
  
    
   
    @IBAction func saveClicked(_ sender: Any) {
        let firestoreDatabase = Firestore.firestore()
        var firestorereference : DocumentReference? = nil
        let firestorePost = ["dersinadi": self.dersadiField.text!,"not": self.notField.text!] as [String : Any]
        firestorereference = firestoreDatabase.collection("notlar").addDocument(data: firestorePost, completion: { error in
            if error != nil {
                print("Error")
            }
           
        })
    }
    
}

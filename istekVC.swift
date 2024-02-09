//
//  istekVC.swift
//  studentSystem
//
//  Created by Olgun ‏‏‎‏‏‎ on 8.02.2024.
//

import UIKit
import Firebase
import FirebaseFirestore

class istekVC: UIViewController {
    @IBOutlet weak var baslikLabel: UITextField!
    @IBOutlet weak var icerikLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func sendClicked(_ sender: Any) {
        let firestoredatabase = Firestore.firestore()
        var firestorereference : DocumentReference? = nil
        let firestorePost = ["baslik" : self.baslikLabel.text!,"icerik" : self.icerikLabel.text!] as [String : Any]
        firestorereference = firestoredatabase.collection("sikayetler").addDocument(data:firestorePost, completion: { error in
            if error != nil {
                self.makeAlert(title: "Error", message: "Sorun oluştu.")
            }
        })
        self.makeAlert(title: "Başarılı", message: "İsteğin gönderildi.")
        
        
    }
    func makeAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    

}

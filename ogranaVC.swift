
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class ogranaVC: UIViewController {
    var subeArray = [String]()
    
    @IBOutlet weak var adLabel: UILabel!
    @IBOutlet weak var ortalamaLabel: UILabel!
    @IBOutlet weak var sinifLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userEmail = Auth.auth().currentUser?.email {
            self.adLabel.text = userEmail
        }
        
        getdatafromFirestore() // Firestore'dan verileri alma fonksiyonunu çağır
    }
    @IBAction func dersprogramiClicked(_ sender: Any) {
            self.performSegue(withIdentifier: "programVC", sender: nil)
        }
        
        @IBAction func sonucClicked(_ sender: Any) {
            self.performSegue(withIdentifier: "sonucVC", sender: nil)
        }
        
        @IBAction func katilVC(_ sender: Any) {
            self.performSegue(withIdentifier: "yoklamagirVC", sender: nil)
        }
        @IBAction func duyurularClicked(_ sender: Any) {
            self.performSegue(withIdentifier: "duyurularVC", sender: nil)
        }
        @IBAction func isteklerClicked(_ sender: Any) {
            self.performSegue(withIdentifier: "isteklerVC", sender: nil)
        }
        @IBAction func cikisyapClicked(_ sender: Any) {
            self.performSegue(withIdentifier: "cikildiVC", sender: nil)
        }
    
    // Diğer fonksiyonlarınız buraya
    
    func getdatafromFirestore() {
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("sinifvesube").addSnapshotListener { snapshot,error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true {
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        if let sinif = document.get("sinif") as? String {
                            self.subeArray.append(sinif)
                        }
                    }
                    
                   
                    if let firstSube = self.subeArray.first {
                        self.sinifLabel.text = firstSube
                    }
                    self.ortalamaLabel.text = "2,9"
                }
            }
        }
    }
}

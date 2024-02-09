import UIKit
import Firebase
import FirebaseFirestore

class yoklamaVC: UIViewController {
    var yoklamaArray = [String]()
    @IBOutlet weak var yokmamaText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getdatafromfirestore() // Firestore'dan verileri alma fonksiyonunu çağır
    }

    @IBAction func katilClicked(_ sender: Any) {
        checkYoklama()
    }

    @IBAction func okutClicked(_ sender: Any) {
        checkYoklama()
    }

    func getdatafromfirestore() {
        let firestoredatabase = Firestore.firestore()
        firestoredatabase.collection("yoklama").addSnapshotListener { snapshot,error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.yoklamaArray.removeAll() // Diziyi temizle, çünkü yeniden doldurulacak
                if let snapshot = snapshot, !snapshot.isEmpty {
                    for document in snapshot.documents {
                        if let kod = document.get("yoklamakodu") as? String {
                            self.yoklamaArray.append(kod)
                        }
                    }
                }
            }
        }
    }
    
    func checkYoklama() {
        guard let inputKod = yokmamaText.text else {
            print("Yoklama kodu alınamadı.")
            return
        }

        if yoklamaArray.contains(inputKod) {
            
            self.makeAlert(title: "Başarılı", message: "Yoklamaya katıldın.")
           
        } else {
            self.makeAlert(title: "Error", message: "Kod Eşleşmiyor")
        }
    }
    func makeAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

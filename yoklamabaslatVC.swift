import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class yoklamabaslatVC: UIViewController {
    @IBOutlet weak var sureLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveClicked: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    var remainingSeconds = 3
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveClicked.isEnabled = false
        updateTimerLabel()
        
        
        
        
    }
    @objc func updateTimer() {
        if remainingSeconds > 0 {
            remainingSeconds -= 1
            updateTimerLabel()
            
        }
        else {
            timer?.invalidate()
            sureLabel.text = "Time"
            self.makeAlert(title: "Error", message: "Time")
        }
    }
    func updateTimerLabel() {
            let minutes = remainingSeconds / 60
            let seconds = remainingSeconds % 60
            sureLabel.text = String(format: "%02d:%02d", minutes, seconds)
        }
    
    @IBAction func createClicked(_ sender: Any) {
        if let myString = textField.text, !myString.isEmpty { // Eğer textField boş değilse işleme devam et
            if let data = myString.data(using: .ascii, allowLossyConversion: false) {
                let filter = CIFilter(name: "CIQRCodeGenerator")
                filter?.setValue(data, forKey: "inputMessage") // "inputMessage" küçük harflerle başlamalıdır
                let ciImage = filter?.outputImage
                let transform = CGAffineTransform(scaleX: 10, y: 10)
                let transformImage = ciImage?.transformed(by: transform)
                
                if let image = transformImage {
                    imageView.image = UIImage(ciImage: image)
                    saveClicked.isEnabled = true
                }
            }
        }
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        screenshotMethod()
        
    }
    
    func screenshotMethod() {
        
            
            
            guard let layer = UIApplication.shared.keyWindow?.layer else {
                print("Error: Layer couldn't be accessed.")
                return
            }
            
            let scale = UIScreen.main.scale
            UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
            guard let context = UIGraphicsGetCurrentContext() else {
                print("Error: Couldn't get current context.")
                
                return
                
            }
            
            layer.render(in: context)
            guard let screenshot = UIGraphicsGetImageFromCurrentImageContext() else {
                print("Error: Couldn't take screenshot.")
                return
            }
            
            UIGraphicsEndImageContext()
            UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
        }
    @IBAction func baslatClicked(_ sender: Any) {
    
        let firestoredatabase = Firestore.firestore()
        var firestorereference : DocumentReference? = nil
        let firestorePost = ["yoklamakodu" : self.textField.text!] as [String : Any]
        firestorereference = firestoredatabase.collection("yoklama").addDocument(data:firestorePost, completion: { error in
            if error != nil {
                self.makeAlert(title: "Error", message: "Yoklama başlatılamadı.")
            }
        })
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        self.makeAlert(title: "Başarılı", message: "Yoklama başlatıldı.")
        
    }
    func makeAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

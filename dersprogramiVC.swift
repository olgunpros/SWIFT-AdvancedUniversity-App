//
//  dersprogramiVC.swift
//  studentSystem
//
//  Created by Olgun ‏‏‎‏‏‎ on 8.02.2024.
//

import UIKit
import Firebase
import FirebaseFirestore


class dersprogramiVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var ders1Array = [String]()
    var ders2Array = [String]()
    var gunArray = [String]()
    
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getdatafromFirestore()
    }
    
    func getdatafromFirestore() {
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("dersprogrami").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            }
            else {
                if snapshot?.isEmpty != true {
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                    
                        if let ders1 = document.get("ders1") as? String {
                            self.ders1Array.append(ders1)
                        }
                        if let ders2 = document.get("ders2") as? String {
                            self.ders2Array.append(ders2)
                        }
                        if let gun = documentID as? String {
                            self.gunArray.append(gun)
                        }
                        
                        
                       
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ders1Array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell
        cell.ders1Label.text = ders1Array[indexPath.row]
        cell.ders2Label.text = ders2Array[indexPath.row]
        cell.gunLabel.text = gunArray[indexPath.row]
        return cell
    }

    

}

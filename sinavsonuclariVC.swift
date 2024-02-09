//
//  sinavsonuclariVC.swift
//  studentSystem
//
//  Created by Olgun ‏‏‎‏‏‎ on 8.02.2024.
//

import UIKit
import Firebase
import FirebaseFirestore

class sinavsonuclariVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var dersadiArray = [String]()
    var notArray = [String]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getdatafromfirestore()
        
    }
    
    func getdatafromfirestore() {
        let fireStoredatabase = Firestore.firestore()
        fireStoredatabase.collection("notlar").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            else {
                if snapshot?.isEmpty != true {
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        
                        if let not = document.get("not") as? String {
                            self.notArray.append(not)
                        }
                        
                        if let ders = document.get("dersinadi") as? String {
                            self.dersadiArray.append(ders)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dersadiArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! sonucCell
        cell.dersadiLabel.text = dersadiArray[indexPath.row]
        cell.notLabel.text = notArray[indexPath.row]
        return cell
        
    }
    


}

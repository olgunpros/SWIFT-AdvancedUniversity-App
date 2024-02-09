//
//  duyurularVC.swift
//  studentSystem
//
//  Created by Olgun ‏‏‎‏‏‎ on 8.02.2024.
//

import UIKit
import Firebase
import FirebaseFirestore
class duyurularVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var duyuruadiArray = [String]()
    var duyuruicerikArray = [String]()
    
    
   
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getdatafromfirestore()

        
    }
    func getdatafromfirestore() {
        let fireStoredatabase = Firestore.firestore()
        fireStoredatabase.collection("duyurular").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            else {
                if snapshot?.isEmpty != true {
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        
                        if let duyuruicerik = document.get("icerik") as? String {
                            self.duyuruicerikArray.append(duyuruicerik)
                        }
                        if let duyuruadi = documentID as? String {
                            self.duyuruadiArray.append(duyuruadi)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return duyuruadiArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! duyuruCell
        cell.baslikLabel.text = duyuruadiArray[indexPath.row]
        cell.icerikLabel.text = duyuruicerikArray[indexPath.row]
        return cell
        
    }
    
   

}

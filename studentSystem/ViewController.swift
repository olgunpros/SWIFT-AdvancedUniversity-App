//
//  ViewController.swift
//  studentSystem
//
//  Created by Olgun ‏‏‎‏‏‎ on 8.02.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signinClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "ogrenciVC", sender: nil)
    }
    @IBAction func signinClickedd(_ sender: Any) {
        self.performSegue(withIdentifier: "ogretmenVC", sender: nil)
    }
    
}


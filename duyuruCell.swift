//
//  duyuruCell.swift
//  studentSystem
//
//  Created by Olgun ‏‏‎‏‏‎ on 8.02.2024.
//

import UIKit

class duyuruCell: UITableViewCell {
    
    @IBOutlet weak var baslikLabel: UILabel!
    
    @IBOutlet weak var icerikLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

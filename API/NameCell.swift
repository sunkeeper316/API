//
//  NameCell.swift
//  API
//
//  Created by 黃德桑 on 2019/5/16.
//  Copyright © 2019 sun. All rights reserved.
//

import UIKit

class NameCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbSurname: UILabel!
    
    @IBOutlet weak var lbGender: UILabel!
    
    @IBOutlet weak var lbregion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

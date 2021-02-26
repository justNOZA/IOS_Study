//
//  ListTableCell.swift
//  RAKUTEN
//
//  Created by Pasonatech on 2021/02/25.
//

import UIKit

class ListTableCell: UITableViewCell {

    @IBOutlet weak var listImg: UIImageView!
    @IBOutlet weak var listLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

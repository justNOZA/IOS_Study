//
//  ContentTVCell.swift
//  RAKUTEN
//
//  Created by Pasonatech on 2021/02/24.
//
import UIKit

class LibTableViewCell: UITableViewCell {

    @IBOutlet weak var libImg: UIImageView!
    @IBOutlet weak var libTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

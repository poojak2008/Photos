//
//  PhotoTableViewCell.swift
//  albums
//
//  Created by Mac on 08/04/25.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var albumIdLable: UILabel!
    
    @IBOutlet weak var idLable: UILabel!
    
    @IBOutlet weak var titleLable: UILabel!
    
    
    @IBOutlet weak var imageView1: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

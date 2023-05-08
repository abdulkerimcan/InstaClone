//
//  TableViewCell.swift
//  InstaClone
//
//  Created by Abdulkerim Can on 7.05.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var userEmailText: UILabel!
    
    @IBOutlet weak var likesText: UILabel!
    
    @IBOutlet weak var descriptionText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClick(_ sender: Any) {
    }
}

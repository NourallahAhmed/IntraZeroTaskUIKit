//
//  PhotoListTableViewCell.swift
//  IntraZeroTaskUIKit
//
//  Created by NourAllah Ahmed on 14/08/2022.
//

import UIKit

class PhotoListTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var autherLabel: UILabel!
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.addSubview(photoImage)
//        photoImage.leftAnchor.con
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

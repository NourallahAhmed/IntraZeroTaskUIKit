//
//  CustomHeader.swift
//  IntraZeroTaskUIKit
//
//  Created by NourAllah Ahmed on 15/08/2022.
//

import UIKit

class CustomHeader: UITableViewHeaderFooterView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    
               
            
     
        let image = UIImageView()

        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            configureContents()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        func configureContents() {
            image.translatesAutoresizingMaskIntoConstraints = false

            contentView.addSubview(image)

       
            NSLayoutConstraint.activate([
                image.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
                image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 5),
                image.heightAnchor.constraint(equalToConstant: 90),
                image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
         
            ])
            
         

        }
    }



//
//  CardView.swift
//  IntraZeroTaskUIKit
//
//  Created by NourAllah Ahmed on 17/08/2022.
//

import UIKit


@IBDesignable class CardView: UIView {
    @IBInspectable var cornnerRadius : CGFloat = 15
           
           override func layoutSubviews() {
               layer.cornerRadius = self.cornnerRadius
               layer.masksToBounds = true
       }

   
    
}

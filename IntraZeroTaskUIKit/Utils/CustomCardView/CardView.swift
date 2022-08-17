//
//  CardView.swift
//  IntraZeroTaskUIKit
//
//  Created by NourAllah Ahmed on 17/08/2022.
//

import UIKit



@IBDesignable class CardView: UIImageView {
    
    @IBInspectable var cornnerRadius : CGFloat = 20
    var offSetWidth : CGFloat = 10
    var ofSetHeight: CGFloat = 10
    @IBInspectable var ofSetShadowOpacity : Float = 10
    @IBInspectable var colour = UIColor.systemGray4
    
    override func layoutSubviews() {
        layer.cornerRadius = self.cornnerRadius
        layer.shadowColor = self.colour.cgColor
        layer.shadowOffset = CGSize(width: self.offSetWidth , height : self.ofSetHeight)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornnerRadius).cgPath
        layer.shadowOpacity = self.ofSetShadowOpacity
        layer.masksToBounds = true
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

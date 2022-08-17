//
//  CustomView.swift
//  IntraZeroTaskUIKit
//
//  Created by NourAllah Ahmed on 17/08/2022.
//

import UIKit

class CustomView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
   

        lazy var cardImage: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false // To flag that we are using Constraints to set the layout
            image.image = UIImage(named: "default")
            image.contentMode = .scaleAspectFit
            image.layer.cornerRadius  = 20
            image.layer.masksToBounds = true
            return image
        }()

        lazy var gradientView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false // IMPORTANT IF YOU ARE USING CONSTRAINTS INSTEAD OF FRAMES
                
            return view
        }()

        // VStack equivalent in UIKit
        lazy var contentStack: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.distribution = .fillProportionally // Setting the distribution to fill based on the content
            return stack
        }()

        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 0 // Setting line number to 0 to allow sentence breaks
            label.text = "Let your curiosity do the booking"
            label.font = UIFont(name: "HelveticaNeue-Bold", size: 20) // Custom font defined for the project
            label.textColor = .black
            
            return label
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }

        private func commonInit() {
            self.addSubview(cardImage) // Adding the subview to the current view. i.e., self

            // Setting the corner radius of the view
            self.layer.cornerRadius = 30
            self.layer.masksToBounds = true

            NSLayoutConstraint.activate([
                cardImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                cardImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                cardImage.topAnchor.constraint(equalTo: self.topAnchor),
//                cardImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                cardImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50)
            ])

            setupGradientView()
            addTextAndButton()
        }

        private func setupGradientView() {
            let height = self.frame.height * 0.2 // Height of the translucent gradient view

            self.addSubview(gradientView)
            NSLayoutConstraint.activate([
                gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                gradientView.topAnchor.constraint(equalTo: self.cardImage.bottomAnchor, constant: -20)
            ])

            // Adding the gradient
            let colorTop =  UIColor.clear
            let colorBottom = UIColor.clear
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = CGRect(
                x: 0,
                y: self.frame.height - height,
                width: self.frame.width,
                height: height)
            gradientView.layer.insertSublayer(gradientLayer, at:0)
        }

        private func addTextAndButton() {

            // Adding the views to the stackview
            contentStack.addArrangedSubview(titleLabel)

            gradientView.addSubview(contentStack)
            NSLayoutConstraint.activate([
                contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor) ,// constant: 20),
                contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor), // constant: -20),    // Negative for leading and bottom constraints
                contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor), // constant: -20),        // Negative for leading and bottom constraints
                contentStack.topAnchor.constraint(equalTo:  self.cardImage.bottomAnchor , constant: -20)

            ])

        }

    

}

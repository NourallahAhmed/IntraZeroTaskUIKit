//
//  PhotoDetailsViewModel.swift
//  IntraZeroTaskUIKit
//
//  Created by NourAllah Ahmed on 14/08/2022.
//

import Foundation
import UIKit
import UIImageColors
class PhotosDetailsViewModel  {
    private var backgroundColor : UIColor?
     var loaded = false
    private var imageData : Data?
    func getBackgoundColor(url : URL , completion: @escaping (UIColor) -> Void) {
        self.backgroundColor = .white
        DispatchQueue.global(qos: .userInteractive).async {
            let imageData2 = try! NSData(contentsOf: url ) as Data
            DispatchQueue.main.async {
                self.imageData = imageData2
                let image = UIImage(data: self.imageData!)
                self.backgroundColor = image?.getColors()?.primary
                self.loaded = true
                completion(self.backgroundColor ?? .white)
            }
        }
        
    }
}

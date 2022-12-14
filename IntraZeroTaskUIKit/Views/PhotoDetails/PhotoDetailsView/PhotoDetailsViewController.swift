//
//  PhotoDetailsViewController.swift
//  IntraZeroTaskUIKit
//
//  Created by NourAllah Ahmed on 14/08/2022.
//

import UIKit
import Kingfisher

class PhotoDetailsViewController: UIViewController {
    let indicator = UIActivityIndicatorView(style: .large)

    @IBOutlet var backgroundview: UIView!
 
    @IBOutlet weak var photoImage: UIImageView!
    var url : String?
    var photoDetailsViewModel = PhotosDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        // Do any additional setup after loading the view.
        guard let imageUrl = URL(string: self.url ?? "") else {
            return
        }
        
        
        
        self.photoDetailsViewModel.getBackgoundColor(url: imageUrl) { color in
            self.indicator.stopAnimating()
            self.backgroundview.backgroundColor = color
            self.photoImage?.kf.setImage(with: imageUrl,
                                         placeholder: UIImage(named: "default.png") ,
                                         options: nil,
                                         progressBlock: nil)
            self.photoImage?.layer.cornerRadius = 30
            self.photoImage?.layer.masksToBounds = true
            self.photoImage?.clipsToBounds = true
            }
            
        }
     
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

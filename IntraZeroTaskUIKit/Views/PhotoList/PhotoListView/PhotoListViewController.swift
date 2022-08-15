//
//  PhotoListViewController.swift
//  IntraZeroTaskUIKit
//
//  Created by NourAllah Ahmed on 14/08/2022.
//

import UIKit
import Kingfisher
class PhotoListViewController: UIViewController {

    

    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var photosTableVIew: UITableView!
    var page : Int = 1
    var photoListViewModel : PhotosListViewModel?
    var photoList :[[Photo]]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photosTableVIew.delegate = self
        self.photosTableVIew.dataSource = self
        
        self.photoListViewModel = PhotosListViewModel(view: self)
        self.photoListViewModel?.changePage(page: String(page),completion: { photoGrouped in
            self.photoList = photoGrouped
            self.photosTableVIew.reloadData()
            print(self.photoList)
        })
        
        self.pageTitle.text = "Welcome"
        
        
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
extension PhotoListViewController : UITableViewDelegate , UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 //self.photoList?.count ?? 0
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoListTableViewCell
        if ((photoList?.isEmpty) == nil) {
                print("Nil")
        }
        else{
            cell.imageView?.image = UIImage(named: "default.png")
            let imageUrl = URL(string: photoList?[0][indexPath.row].downloadUrl ?? "")
            cell.imageView?.kf.setImage(with: imageUrl,
                                     placeholder: UIImage(named: "default.png") ,
                                     options: nil,
                                     progressBlock: nil)
            
            cell.autherLabel.text =  photoList?[0][indexPath.row].author
            return cell
        }
        return UITableViewCell()
    }


}



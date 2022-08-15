//
//  PhotoListViewController.swift
//  IntraZeroTaskUIKit
//
//  Created by NourAllah Ahmed on 14/08/2022.
//

import UIKit

class PhotoListViewController: UIViewController {

    

    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var photosTableVIew: UITableView!
    var page : Int = 1
    var photoListViewModel : PhotosListViewModel?
    var photoList : [Photo]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photosTableVIew.delegate = self
        self.photosTableVIew.dataSource = self
        
        self.photoListViewModel = PhotosListViewModel(view: self)
        self.photoListViewModel?.changePage(page: String(page))
        
        
        
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoListTableViewCell
        
//        cell.photoImage =
          
              // Configure the cell
          
        return cell
    }
    
    
}

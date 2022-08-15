//
//  PhotoListViewController.swift
//  IntraZeroTaskUIKit
//
//  Created by NourAllah Ahmed on 14/08/2022.
//

import UIKit
import Kingfisher
class PhotoListViewController: UIViewController {

    
    @IBOutlet weak var nextBtnText: UIButton!
    @IBOutlet weak var previousBtnText: UIButton!
    
    @IBOutlet weak var pageNum: UILabel!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var photosTableVIew: UITableView!
    
    var page : Int = 1
    var photoListViewModel : PhotosListViewModel?
    var photoList :[[Photo]]?
    
    
    
    let images = ["macAD" ,"papajohnsAd" , "cocacolaAD"  ]
    var activeImageIndex = 0
    
    let imageSwitchTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.photosTableVIew.delegate = self
        self.photosTableVIew.dataSource = self
        
        self.pageNum.text = ""

        self.photoListViewModel = PhotosListViewModel(view: self)
       
        self.RequestData()
        self.pageTitle.text = "Welcome"
        self.previousBtnText.setTitle("", for: UIControl.State.normal)
//
//        self.photosTableVIew.register(CustomHeader.self,
//            forHeaderFooterViewReuseIdentifier: "sectionHeader")
//        self.photosTableVIew.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)

        
    }
    @IBAction func nextBtn(_ sender: UIButton) {
        self.previousBtnText.setTitle("previous", for: UIControl.State.normal)
        self.page += 1
        self.RequestData()
        
    }
    @IBAction func previousBtn(_ sender: UIButton) {
        if page > 0 {
            self.page -= 1
            self.RequestData()
        }
        if page == 1{
            self.previousBtnText.setTitle("", for: UIControl.State.normal)

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func RequestData(){
        self.photoListViewModel?.changePage(page: String(page),completion: { photoGrouped in
            self.photoList = photoGrouped
            self.photosTableVIew.rowHeight =  200 // UIScreen.main.bounds.height / 4
            self.nextBtnText.setTitle("next", for: UIControl.State.normal)
            self.photosTableVIew.reloadData()
            self.pageNum.text = self.page.description
        })
    }

}

extension PhotoListViewController : UITableViewDelegate , UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        self.photoList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoList?[section].count ?? 0
    }

//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let adView = UIImageView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
//
//        adView.image = UIImage( named: "macAD")
//
//        return adView
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return  30
//    }
//
//     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return section == 0 ? 0 : 32
//        }
//    func tableView(_ tableView: UITableView,
//                   viewForHeaderInSection section: Int) -> UIView? {
//        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
//                                                                "sectionHeader") as! CustomHeader
//        view.image.image = UIImage(named:"macAD")
////        UIImage.animatedImageNamed(images[activeImageIndex], duration: 10)
////        self.activeImageIndex += 1
//        return view
//    }
    
    
    
    //MARK: CEll
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoListTableViewCell
        if ((photoList?.isEmpty) == nil) {
                print("Nil")
        }
        
        else{
            
            cell.imageView?.image = UIImage(named: "default.png")
       
            let imageUrl = URL(string: photoList?[indexPath.section][indexPath.row].downloadUrl ?? "")
            cell.imageView?.kf.setImage(with: imageUrl,
                                     placeholder: UIImage(named: "default.png") ,
                                     options: nil,
                                        progressBlock: nil)
            
            cell.autherLabel.text =  photoList?[indexPath.section][indexPath.row].author
            cell.imageView?.contentMode = .scaleAspectFit

//            cell.imageView?.layer.masksToBounds = true


            return cell
        }
        return UITableViewCell()
    }
    //MARK: didSelectRowAt
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
          let photoDetails = self.storyboard?.instantiateViewController(identifier: "photoDetailsScreen") as! PhotoDetailsViewController
          photoDetails.url = photoList?[0][indexPath.row].downloadUrl

         photoDetails.modalPresentationStyle = .automatic

          self.present(photoDetails, animated: true, completion: nil)

      }
    
}




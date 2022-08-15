//
//  PhotoListViewModel.swift
//  IntraZeroTaskUIKit
//
//  Created by NourAllah Ahmed on 14/08/2022.
//

import Foundation
import Network

protocol photosListProtocol {
    func changePage(page:String)
}
class PhotosListViewModel : photosListProtocol {
    
    var photosList : [Photo] = [Photo] ()
    var photosListGrouped = [[Photo]]()
    var photoLoaded = false
    var photoListView : PhotoListViewController?
    
    //MARK: Network
    var networkLayer = NetworkAPI.networkApi
   
    
    init( view : PhotoListViewController ){
        self.photoListView = view
    }
    func changePage(page: String) {
        self.photoLoaded = false
        DispatchQueue.global(qos: .userInitiated).async {
            self.networkLayer.changePage(page: page ,completion: { result in
                DispatchQueue.main.async {
                    guard let photos = try? result.get() else{
                        return
                    }
                    self.photosList = photos
                    self.photosListGrouped =  self.photosList.dividedIntoGroups(of: 5)
                    self.photoLoaded = true
                }
            })
        }
    }
    
  
}

extension Array {
    func dividedIntoGroups(of i: Int = 5) -> [[Element]] {
        var copy = self
        var res = [[Element]]()
        while copy.count > i {
            res.append( (0 ..< i).map { _ in copy.remove(at: 0) } )
        }
        res.append(copy)
        return res
    }
}

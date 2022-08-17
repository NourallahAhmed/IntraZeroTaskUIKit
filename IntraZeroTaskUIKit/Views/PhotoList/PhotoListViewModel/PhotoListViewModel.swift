//
//  PhotoListViewModel.swift
//  IntraZeroTaskUIKit
//
//  Created by NourAllah Ahmed on 14/08/2022.
//

import Foundation
import Network

protocol photosListProtocol {
    func changePage(page:String , completion : @escaping ([[Photo]]) -> Void)
    func saveOffline(photosList: [Photo]) -> Void
    func fetchLocalData()
}
class PhotosListViewModel : photosListProtocol {
    
    
    var photosList : [Photo] = [Photo] ()
    var photosListGrouped = [[Photo]]()
    var photoLoaded = false
    
    //MARK: CoreData
    var appDelegate : AppDelegate
    var dataBaseInstance : DataBaseHandling?
    
    //MARK: NetworkLayer
    var networkLayer : NetworkAPIProtocol
   
    //MARK: NetworkConnection
    var monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")

    
    init( appDelegate :  AppDelegate , networkLayer : NetworkAPIProtocol){
        self.appDelegate  = appDelegate
        self.dataBaseInstance = DataBaseHandling(appDelegate: self.appDelegate)
        self.networkLayer = networkLayer
    }
    
    
    func changePage(page: String , completion : @escaping ([[Photo]]) -> Void) {
        self.photoLoaded = false
        
        monitor.pathUpdateHandler = { [weak self] pathUpdateHandler  in
           if pathUpdateHandler.status == .satisfied {
               DispatchQueue.global(qos: .userInitiated).async {
                   self?.networkLayer.changePage(page: page ,completion: { result in
                       DispatchQueue.main.async {
                           guard let photos = try? result.get() else{
                               return
                           }
                           self?.photosList = photos
                           self?.photosListGrouped =  self?.photosList.dividedIntoGroups(of: 5) ?? [[]]
                           self?.photoLoaded = true
                           //TODO: Save Local
                           self?.saveOffline(photosList: self?.photosList ?? [])
                           completion(self?.photosListGrouped ?? [[]])
                       }
                   })
               }
           }
            else{
                DispatchQueue.global(qos: .userInitiated).async {
                        self?.fetchLocalData()
                }
                DispatchQueue.main.async{
                    completion(self?.photosListGrouped ?? [[]])

                }
            }
        }
        monitor.start(queue: queue)
    }
    
    
    func saveOffline(photosList: [Photo]) {
        self.dataBaseInstance?.saveLocally(photoslist: photosList)
    }
    
    func fetchLocalData(){
        self.photosList = self.dataBaseInstance?.getLocalData() ?? []
        self.photosListGrouped  = self.photosList.dividedIntoGroups(of: 5)
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

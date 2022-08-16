//
//  DataBase.swift
//  IntraZeroTaskUIKit
//
//  Created by NourAllah Ahmed on 16/08/2022.
//

import Foundation
import CoreData
class DataBaseHandling {
    

    private var viewContext : NSManagedObjectContext = NSManagedObjectContext()
    private var photosNSManagedObject : NSManagedObject = NSManagedObject()
    private var fetchingPhotos: [NSManagedObject] = []
    private var entity : NSEntityDescription?
    var appdelegate : AppDelegate?
    init ( appDelegate : AppDelegate) {
        self.appdelegate = appDelegate
        self.viewContext = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Photos", in: viewContext)
    }
    
    
    func saveLocally(photoslist : [Photo]? ) -> Void {
        self.deleteLocalData()
        for item in photoslist ?? [] {
            var photo = NSManagedObject(entity: entity!, insertInto: viewContext)
            photo.setValue(item.id, forKey: "id")
            photo.setValue(item.url, forKey: "url")
            photo.setValue(item.downloadUrl, forKey: "downloadUrl")
            photo.setValue(item.author, forKey: "auther")
            photo.setValue(item.height, forKey: "height")
            photo.setValue(item.width, forKey: "width")
            do{
                try viewContext.save()
                print("saved!")
                
            }
            catch let error{
                print(error.localizedDescription)
                
            }
            
        }
        
        
        
        }
    
    
    
    func deleteLocalData() {
        
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Photos")
//        fetchRequest.predicate = NSPredicate.init(format: "idLeague==\(deleted.idLeague!)")
//
//        do {
//            let objects = try viewContext.fetch(fetchRequest)
//            for object in objects {
//                viewContext.delete(object)
//            }
//            try viewContext.save()
//        }catch{
//            print("Couldn't delete movie!")
//        }
        
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Photos")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
        }
         
    }
    
   
    func getLocalData() -> [Photo]?
    {
        
        print("getLocalData")
        var photoStored : Photo?
        var photolist : [Photo]?
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Photos")

        do{
            print("start Fetching")
            fetchingPhotos = try! viewContext.fetch(fetch)
            photolist=[]
            for item in fetchingPhotos{
                photoStored = Photo(
                    id: item.value(forKey: "id") as? String ?? "" ,
                    author: item.value(forKey: "auther") as? String ?? "",
                    width: item.value(forKey: "width") as? Int16 ?? 0,
                    height:  item.value(forKey: "height") as? Int16 ?? 0,
                    url:  item.value( forKey: "url") as? String ?? "",
                    downloadUrl: item.value(forKey: "downloadUrl") as? String ?? "")
                
                photolist?.append(photoStored!)
                print("appended!")
            }
        }
        catch{
            print("Couldn't fetch!")
        }
       return photolist
    }


    
}

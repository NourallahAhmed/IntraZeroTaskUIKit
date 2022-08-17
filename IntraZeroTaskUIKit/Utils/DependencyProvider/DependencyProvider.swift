//
//  DependencyProvider.swift
//  IntraZeroTaskUIKit
//
//  Created by NourAllah Ahmed on 17/08/2022.
//

import Foundation
import UIKit

struct DependencyProvider{
    
    static var networkAPIInstance : NetworkAPIProtocol {
        return NetworkAPI()
    }
    
    static var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    static var photoListViewModelInstance: PhotosListViewModel {
        return PhotosListViewModel(appDelegate:  DependencyProvider.appDelegate, networkLayer: DependencyProvider.networkAPIInstance)
    }
    
    static var  photoListViewController  : PhotoListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let screen = storyboard.instantiateViewController(withIdentifier: "cv")
        as! PhotoListViewController
        screen.photoListViewModel = DependencyProvider.photoListViewModelInstance
        return screen
    }
}

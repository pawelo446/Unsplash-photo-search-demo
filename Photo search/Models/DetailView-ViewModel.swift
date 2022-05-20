//
//  DetailViewController.swift
//  Photo search
//
//  Created by Paweł on 17/05/2022.
//

import Foundation
import UIKit

extension DetailView {
    @MainActor class ViewModel: ObservableObject {
        let photoURL: String
        let description: String?
        
        init(photoURL: String, description: String?){
            self.photoURL = photoURL
            self.description = description
        }
        
        func saveToGallery() {
            guard let imageForSave = photoURL.loadPhotoFromURL() else { return }
            UIImageWriteToSavedPhotosAlbum(imageForSave, nil, nil, nil)
        }
    }
}



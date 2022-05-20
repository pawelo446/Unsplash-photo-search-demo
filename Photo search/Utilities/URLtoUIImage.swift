//
//  URLtoUIImage.swift
//  Photo search
//
//  Created by Paweł on 18/05/2022.
//

import Foundation
import SwiftUI

extension String {
    func loadPhotoFromURL() -> UIImage? {
        guard let url = URL(string: self),
              let data: Data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }
}

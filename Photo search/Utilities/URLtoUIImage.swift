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

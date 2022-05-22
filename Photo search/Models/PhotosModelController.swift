import Foundation
import SwiftUI

enum Constants {
    static var apiKey: String { "bfeknoZmShMsBPmD_6ZNp_0QUtkMcOAX5tP5UiKHDNs" }
}

protocol PhotosModelController{
    func fetchPhotos(phrase: String, page: Int, completion: @escaping (Result<APIResponse, APError>) -> Void)
}

class PhotosModelControllerImpl: PhotosModelController {
    func fetchPhotos(phrase: String, page: Int, completion: @escaping (Result<APIResponse, APError>) -> Void) {
        let urlString = "https://api.unsplash.com/search/photos?page=\(page)&per_page=30&query=\(phrase.replacingOccurrences(of: " ", with: "+").lowercased())&client_id=\(Constants.apiKey)"

        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            let decoder = JSONDecoder()
            if let result = try? decoder.decode(APIResponse.self, from: data) {
                completion(.success(result))
            } else{
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}



import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var searchValue = "Swift"
        @Published var photos: [Picture] = []
        var modelController = PhotosModelControllerImpl()
        var totalPages = 0
        var currentPage = 1
        var alertItem: AlertItem?
        
        func fetchInitialItems() {
            currentPage = 1
            var fetchedPictures: [Picture] = []
            var totalPages = 0
            let group = DispatchGroup()
            group.enter()
            modelController.fetchPhotos(phrase: searchValue, page: currentPage) { result in
                switch result {
                case .success(let apiResponse):
                    fetchedPictures = apiResponse.results
                    totalPages = apiResponse.total_pages
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
        
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                }
                group.leave()
            }
            group.wait()
            self.totalPages = totalPages
            photos = fetchedPictures
        }
        
        func loadMore(currentItem: Picture? = nil) {
            if (shouldLoadMoreData(currentItem: currentItem)) {
                currentPage += 1
                var fetchedPictures: [Picture] = []
                let group = DispatchGroup()
                group.enter()
                modelController.fetchPhotos(phrase: searchValue, page: currentPage) { result in
                    switch result {
                    case .success(let apiResponse):
                        fetchedPictures = apiResponse.results
                        
                    case .failure(let error):
                        switch error {
                        case .invalidData:
                            self.alertItem = AlertContext.invalidData
                            
                        case .invalidURL:
                            self.alertItem = AlertContext.invalidURL
                            
                        case .invalidResponse:
                            self.alertItem = AlertContext.invalidResponse
                            
                        case .unableToComplete:
                            self.alertItem = AlertContext.unableToComplete
                        }
                    }
                    group.leave()
                }
                group.wait()
                photos.append(contentsOf: fetchedPictures)
            } else { return }
        }
        
        func shouldLoadMoreData(currentItem: Picture? = nil) -> Bool {
            if currentPage > totalPages { return false }
            guard let currentItem = currentItem else { return true }
            for n in (photos.count - 6)...(photos.count-1) {
                if n >= 0 && currentItem.id == photos[n].id {
                    return true
                }
            }
            return false
        }
    }
}

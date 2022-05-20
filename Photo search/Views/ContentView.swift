import SwiftUI
import Foundation

struct ContentView: View {
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if(viewModel.photos == []){
                    VStack {
                        Text("No results")
                            .font(.title)
                            .opacity(0.5)
                        Text("Unfortunately we couldn't find any photos.")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .opacity(0.5)
                    }
                    .padding()
                }
                    
                    ScrollView{
                        LazyVGrid(columns: [
                            .init(),
                            .init()
                        ]) {
                            ForEach(viewModel.photos){image in
                                NavigationLink(destination: DetailView(viewModel: DetailView.ViewModel(photoURL: image.urls.full, description: image.description))) {
                                    MainScreenImageView(photoURL: image.urls.small)
                                }
                                .onAppear {
                                    viewModel.loadMore(currentItem: image)
                                }
                            }
                        }
                        .padding(.horizontal, 5)
                    }
                
                    .alert(item: $viewModel.alertItem) { alertItem in
                        Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
                    }
                
                }
            .searchable(text: $viewModel.searchValue, placement: .navigationBarDrawer(displayMode: .always))
            .onSubmit(of: .search, {
                viewModel.fertchinitialitems()
            })
                .navigationTitle("Browse unsplash")
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

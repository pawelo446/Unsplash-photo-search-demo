//
//  DetailView.swift
//  Photo search
//
//  Created by Paweł on 17/05/2022.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var viewModel: ViewModel
    @State private var isShareSheetPresented = false
    
    init(viewModel: ViewModel){
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {

            VStack(alignment: .center) {
                   Spacer()
                        Text(viewModel.description ?? "")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding()
                        
                    
                DetailScreenImageView(photoURL: viewModel.photoURL)
                Spacer()
                
                HStack {
                    Button {
                        viewModel.saveToGallery()
                    } label: {
                        Text("Save")
                        Image(systemName: "square.and.arrow.down.fill")
                }
                    Spacer()
                    Button {
                        self.isShareSheetPresented.toggle()
                    } label: {
                        Text("Share")
                        Image(systemName: "square.and.arrow.up")
                    }
                }
                .padding()
                
            }
            .sheet(isPresented: $isShareSheetPresented) {
                if let photo = viewModel.photoURL.loadPhotoFromURL() {
                    ShareSheetView(activityItems: [photo])
                        
                }
            }
        .padding()
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailView.ViewModel(photoURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Red_Slate_Mountain_1.jpg/800px-Red_Slate_Mountain_1.jpg", description: "Mountain Really big beautifull"))
    }
}

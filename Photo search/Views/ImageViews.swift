//
//  ImageView.swift
//  Photo search
//
//  Created by Paweł on 16/05/2022.
//

import SwiftUI

struct MainScreenImageView: View {
    let photoURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: photoURL)) { image in
                image
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .cornerRadius(5)
        } placeholder: {
            ProgressView()
                .frame(width: 200, height: 200)
        }
    }
}

struct DetailScreenImageView: View {
    let photoURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: photoURL)) { image in
                image
                .resizable()
                .scaledToFit()
                .frame(width: nil, height: nil)
                .cornerRadius(5)
        } placeholder: {
            ProgressView()
                .frame(width: nil, height: nil)
        }
    }
}


struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenImageView(photoURL: "https://scontent-frx5-1.xx.fbcdn.net/v/t1.6435-9/93008744_2284505048511202_1859902176982204416_n.jpg?_nc_cat=100&ccb=1-6&_nc_sid=730e14&_nc_ohc=YEGE4ZxbuEgAX8Ft7x8&tn=QOlOZI527-z_-qcH&_nc_ht=scontent-frx5-1.xx&oh=00_AT9asz9mJeeQp9Z-jCeWAW0rOTwQhdp7G-D1WOv7Af3kyA&oe=62A87DFB")
    }
}

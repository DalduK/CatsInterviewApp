//
//  URLImageView.swift
//  DOOKZadanie
//
//  Created by Przemysław Woźny on 16/12/2021.
//

import Foundation
import SwiftUI

struct URLImageView: View{
    var urlString: String
    @StateObject var imageLoader = ImageLoaderService()
    @State var image: UIImage = UIImage()
    var body: some View{
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(5)
            .onReceive(imageLoader.$image) { image in
                self.image = image
            }
            .onAppear {
                imageLoader.loadImage(urlString: urlString)
            }
    }
    
}

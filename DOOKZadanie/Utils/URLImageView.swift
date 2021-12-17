import Foundation
import SwiftUI

struct URLImageView: View {
    var urlString: String
    @StateObject var imageLoader = ImageLoaderService()
    @State var image: UIImage = UIImage()
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onReceive(imageLoader.$image) { image in
                self.image = image
            }
            .onAppear {
                imageLoader.loadImage(urlString: urlString)
            }
    }
}

import Foundation
import SwiftUI

struct URLImageView: View {
    var urlString: String
    @StateObject var imageLoader = ImageLoaderService()
    @State var image: UIImage = UIImage()
    @State var loaded: Bool = false
    var body: some View {
        ZStack{
            if loaded == false {
                ProgressView().accessibilityIdentifier("progress").scaleEffect(1.5)
            }
                
            Image(uiImage: image)
                .resizable()
                .onReceive(imageLoader.$image) { image in
                    self.image = image
                }
                .accessibilityLabel("CatImage")
        }
            .onAppear {
                imageLoader.loadImage(urlString: urlString){ loaded in
                    self.loaded = loaded
                }
            }
    }
}

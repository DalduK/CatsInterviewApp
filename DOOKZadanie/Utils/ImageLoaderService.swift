import Foundation
import UIKit


public class ImageLoaderService: ObservableObject {
    @Published var image: UIImage = UIImage()
    
    func loadImage(urlString: String, completionHandler: @escaping (Bool) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data) ?? UIImage()
                completionHandler(false)
            }
        }
        task.resume()
    }
    
}

import Foundation
import UIKit


public class ImageLoaderService: ObservableObject {
    @Published var image: UIImage = UIImage()
    
    func loadImage(urlString: String, completionHandler: @escaping (Bool) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            if let error = error {
                print("Error with fetching pics: \(error)")
                completionHandler(false)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data) ?? UIImage()
                completionHandler(true)
            }
        }
        task.resume()
    }
}

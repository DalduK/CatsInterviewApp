import SwiftUI

struct CatDetailView: View {
    let name : String
    let picURL : String
    let wikipediaURL: String
    let description: String
    
    init(name: String,picURL:String,wikipediaURL:String, description:String) {
        self.name = name
        self.picURL = picURL
        self.wikipediaURL = wikipediaURL
        if description.isEmpty {
            self.description = "Cat has no description 😿"
        }else{
            self.description = description
        }
    }
    
    var body: some View {
        VStack {
            URLImageView(urlString: picURL).padding()
            Text(name)
            if wikipediaURL != "" {
                Link("Learn more about \(name)", destination: URL(string:wikipediaURL)!)
            }
            Text(description)
        }
    }
}


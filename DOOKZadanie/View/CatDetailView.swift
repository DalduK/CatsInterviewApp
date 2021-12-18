import SwiftUI

struct CatDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let name : String
    let picURL : String
    let wikipediaURL: String
    let description: String
    
    init(name: String,picURL:String,wikipediaURL:String, description:String) {
        self.name = name
        self.picURL = picURL
        self.wikipediaURL = wikipediaURL
        if description.isEmpty {
            self.description = "Cat has no name, neither description 😿"
        }else{
            self.description = description
        }
    }
    
    var body: some View {
        VStack {
            Button("Close") {
                self.presentationMode.wrappedValue.dismiss()
            }.padding(.top).accessibilityLabel("DismissModal")
            Spacer()
            VStack{
                URLImageView(urlString: picURL)
                    .aspectRatio(contentMode: .fit).accessibilityLabel("ProgressOrImageSheet")
                HStack{
                    VStack(alignment: .leading){
                        if name != "" {
                            Text(name)
                                .font(.title)
                                .fontWeight(.black)
                                .lineLimit(1)
                        }
                        Text(description)
                            .font(.body)
                            .foregroundColor(.gray)
                        if let wikipediaURL = URL(string: wikipediaURL) {
                            Link(destination: wikipediaURL, label: {
                                Text("Learn more about \(name)")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(40)
                                
                            })
                        }
                        
                    }
                }.padding()
            }.cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.2),lineWidth: 1))
                .padding()
            Spacer()
            
        }
    }
}


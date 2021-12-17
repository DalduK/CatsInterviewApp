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
            }.padding(.top)
            Spacer()
            VStack{
                URLImageView(urlString: picURL)
                    .aspectRatio(contentMode: .fit)
                HStack{
                    VStack(alignment: .leading){
                        Text(name)
                            .font(.title)
                            .fontWeight(.black)
                            .lineLimit(1)
                        Text(description)
                            .font(.body)
                            .foregroundColor(.gray)
                        if wikipediaURL != "" {
                            Link(destination: URL(string:wikipediaURL)!, label: {
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
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray,lineWidth: 1))
                .padding()
            Spacer()
            
        }
    }
}


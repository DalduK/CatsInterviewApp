import SwiftUI

struct CatListView: View {
    @StateObject private var viewModel = CatListViewModel()
    
    var body: some View {
        NavigationView{
            List(viewModel.catsList){ cat in
                VStack{
                    URLImageView(urlString: cat.url)
                    .aspectRatio(contentMode: .fit)
                        .cornerRadius(5)
                    if cat.name != "" {
                        Text(cat.name)
                    }
                }.padding()
                    .onTapGesture {
                        viewModel.selectedCat = cat
                        viewModel.timer.invalidate()
                    }
            }.accessibilityLabel("List").toolbar(content: {
                Button{
                    DispatchQueue.main.async {
                        self.viewModel.getCatsData()
                        self.viewModel.timePassed = 20
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                }.accessibilityIdentifier("refreshButton")
            }).sheet(item: $viewModel.selectedCat, onDismiss: viewModel.countTime){cat in
                CatDetailView(name: cat.name, picURL: cat.url, wikipediaURL: cat.wikiUrl, description: cat.description)
            }.navigationTitle("Cats")
            
        }.navigationViewStyle(.stack)
    }
}

struct CatListView_Previews: PreviewProvider {
    static var previews: some View {
        CatListView()
    }
}


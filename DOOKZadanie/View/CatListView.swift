import SwiftUI

struct CatListView: View {
    @StateObject private var viewModel = CatListViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                Button("Refresh", action: {
                    DispatchQueue.main.async {
                        self.viewModel.getCatsData()
                    }
                })
                List(viewModel.catsList){ cat in
                    VStack{
                        
                        URLImageView(urlString: cat.url)
                        if cat.name != "" {
                            Text(cat.name)
                        }
                    }.padding()
                        .onTapGesture {
                            viewModel.selectedCat = cat
                            viewModel.timer.invalidate()
                        }
                }
            }.sheet(item: $viewModel.selectedCat, onDismiss: viewModel.countTime){cat in
                CatDetailView(name: cat.name, picURL: cat.url, wikipediaURL: cat.wikiUrl, description: cat.description)
            }.navigationTitle("Cats")
        }
    }
}

struct CatListView_Previews: PreviewProvider {
    static var previews: some View {
        CatListView()
    }
}

extension Int: Identifiable {
    public var id: Int { self }
}

//
//  ContentView.swift
//  DOOKZadanie
//
//  Created by Przemysław Woźny on 16/12/2021.
//

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
            List{
                ForEach(0..<viewModel.catsList.count, id:\.self){ cat in
                    VStack{
                        if viewModel.catsList[cat].name != ""{
                            URLImageView(urlString: viewModel.catsList[cat].url).padding()
                            Text(viewModel.catsList[cat].name)
                        }else{
                            URLImageView(urlString: viewModel.catsList[cat].url)
                        }
                    }.onTapGesture {
                        viewModel.selectedCat = cat
                        viewModel.timer.invalidate()
                    }
                }
            }.sheet(item: $viewModel.selectedCat){i in
                CatDetailView(name: viewModel.catsList[i].name, picURL: viewModel.catsList[i].url, wikipedia_URL: viewModel.catsList[i].wiki_url, description: viewModel.catsList[i].description)
            }.navigationTitle("Cats")
            }
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

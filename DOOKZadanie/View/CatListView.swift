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
                    self.viewModel.getCatsData()
                })
            List{
                ForEach(viewModel.catsList){ cat in
                    VStack{
                        URLImageView(urlString: cat.url)
                        Text(cat.name ?? "")
                    }.sheet(isPresented: $viewModel.isPresented){
                        CatDetailView()
                    }.onTapGesture {
                        viewModel.isPresented = true
                    }
                }
            }.navigationTitle("Cats")
            }
        }.onAppear(perform: viewModel.getCatsData)
    }
}

struct CatListView_Previews: PreviewProvider {
    static var previews: some View {
        CatListView()
    }
}

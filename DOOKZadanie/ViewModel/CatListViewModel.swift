//
//  CatListViewModel.swift
//  DOOKZadanie
//
//  Created by Przemysław Woźny on 16/12/2021.
//

import Foundation
import SwiftUI

final public class CatListViewModel : ObservableObject {
    @Published var catsList : [CatInfo] = []
    @Published var selectedCat : Int? = nil
    @Published var isPresented : Bool = false
    @Published var timer = Timer()
    
    init() {
        self.getCatsData()
        self.timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true, block: { _ in
            self.getCatsData()
        })
    }
    
    func getCatsData(){
        getCats{[weak self] cats in
            guard let strongSelf = self else{
                return
            }
            strongSelf.catsList.removeAll()
            for cat in cats {
                DispatchQueue.main.async {
                    if cat.breeds.isEmpty{
                        strongSelf.catsList.append(CatInfo(id: UUID(), url: cat.url, name: "", description: "", wiki_url: ""))
                    }
                    else{
                        if let name = cat.breeds[0]?.name,
                           let desc = cat.breeds[0]?.description,
                           let wiki_url = cat.breeds[0]?.wikipedia_url{
                            strongSelf.catsList.append(CatInfo(id: UUID(), url: cat.url, name: name, description: desc, wiki_url: wiki_url))
                        }
                    }
                }
            }
        }
    }
}

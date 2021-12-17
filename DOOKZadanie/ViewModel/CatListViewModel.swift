//
//  CatListViewModel.swift
//  DOOKZadanie
//
//  Created by Przemysław Woźny on 16/12/2021.
//

import Foundation
import SwiftUI

final public class CatListViewModel :ObservableObject {
    @Published var catsList : [CatInfo]
    @Published var selectedCat : Int? = nil
    @Published var isPresented : Bool = false
    
    init() {
        self.catsList = []
        self.getCatsData()
    }
    
    func getCatsData(){
        getCats{[weak self] cats in
            guard let strongSelf = self else{
                return
            }
            strongSelf.catsList.removeAll()
            for cat in cats {
                if !cat.breeds.isEmpty{
                    DispatchQueue.main.async {
                        strongSelf.catsList.append(CatInfo(id: UUID(), url: cat.url, name: cat.breeds[0]?.name ?? "", description: cat.breeds[0]?.description ?? "", wiki_url: cat.breeds[0]?.wikipedia_url))
                    }
                } else{
                    DispatchQueue.main.async {
                        strongSelf.catsList.append(CatInfo(id: UUID(), url: cat.url, name: "", description: "", wiki_url: ""))
                    }
                }
            }
        }
    }
}

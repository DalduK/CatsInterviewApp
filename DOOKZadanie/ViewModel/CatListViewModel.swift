import Foundation
import SwiftUI

final public class CatListViewModel : ObservableObject {
    @Published var catsList : [CatInfo] = []
    @Published var selectedCat : CatInfo? = nil
    @Published var isPresented : Bool = false
    @Published var timer = Timer()
    var timePassed = 20
    
    init() {
        self.getCatsData()
        countTime()
    }
    
    func countTime() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if self.timePassed == 0{
                self.getCatsData()
                self.timePassed = 20
            }
            self.timePassed -= 1
        })
    }
    
    func getCatsData() {
        getCats{[weak self] cats in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.catsList.removeAll()
                for cat in cats {
                    if cat.breeds.isEmpty {
                        strongSelf.catsList.append(CatInfo(url: cat.url))
                    }
                    else {
                        if let name = cat.breeds[0]?.name,
                           let desc = cat.breeds[0]?.description,
                           let wikiUrl = cat.breeds[0]?.wikipedia_url {
                            strongSelf.catsList.append(CatInfo(url: cat.url, name: name, description: desc, wikiUrl: wikiUrl))
                        } else {
                            //Somtimes there was a problem that there is no wikiURL inside
                            strongSelf.catsList.append(CatInfo(url: cat.url))
                        }
                    }
                }
            }
        }
    }
}

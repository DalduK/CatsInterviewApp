import Foundation
import SwiftUI

final public class CatListViewModel : ObservableObject {
    @Published var catsList : [CatInfo] = []
    @Published var selectedCat : CatInfo? = nil
    @Published var isPresented : Bool = false
    @Published var timer = Timer()
    @Published var apiError : Bool = false
    var apiURL = "https://api.thecatapi.com/v1/images/search?limit=5"
    var timePassed = 20
    
    init() {
        self.getCatsData()
        countTime()
    }
    
    func countTime() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if self.timePassed == 0 {
                self.getCatsData()
                self.timePassed = 20
            }
            self.timePassed -= 1
        })
    }
    
    func getCatsData() {
        getCats(url: apiURL) { [weak self] cats in
            guard let strongSelf = self else {
                return
            }
            if cats.isEmpty {
                DispatchQueue.main.async {
                    strongSelf.apiError = true
                    return
                }
            }
            DispatchQueue.main.async {
                strongSelf.catsList.removeAll()
                for cat in cats {
                    if cat.breeds.isEmpty {
                        strongSelf.catsList.append(CatInfo(url: cat.url))
                    } else {
                        strongSelf.catsList.append(CatInfo(url: cat.url, name: cat.breeds[0]?.name ?? "", description: cat.breeds[0]?.description ?? "", wikiUrl: cat.breeds[0]?.wikipedia_url ?? ""))
                    }
                }
            }
        }
    }
}

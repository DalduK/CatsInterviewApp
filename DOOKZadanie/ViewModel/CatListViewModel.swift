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
                        // Wróciłem do tego brzydkiego sposobu tylko dlatego że w sumie może być opcja że jest imię a nie ma np desc czy wiki url itd. Nie widziałem tego w tym api, ale jest możliwość
                        strongSelf.catsList.append(CatInfo(url: cat.url, name: cat.breeds[0]?.name ?? "", description: cat.breeds[0]?.description ?? "", wikiUrl: cat.breeds[0]?.wikipedia_url ?? ""))
                    }
                }
            }
        }
    }
}

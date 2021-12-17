import Foundation


func getCats(completionHandler: @escaping ([Cat]) -> Void) {
    guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=5") else { return }
    //pobieranie danych i błędów, nie potrzebuję na ten moment response #TODO
    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
        if let error = error {
            print("Error with fetching cats: \(error)")
            return
        }
        
        if let data = data,
           let catsData = try? JSONDecoder().decode([Cat].self, from: data) {
            completionHandler(catsData)
        }
        
    })
    task.resume()
}

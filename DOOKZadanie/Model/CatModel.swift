import Foundation

struct Breed : Decodable {
    let name : String?
    let description: String?
    let wikipediaUrl: String?
}

struct Cat : Decodable, Identifiable {
    let breeds: [Breed?]
    let id: String
    let url: String
    let width: Int
    let height: Int
}

struct CatInfo: Identifiable{
    let id: UUID
    let url: String
    let name: String
    let description: String
    let wikiUrl: String
    init(url: String) {
        self.id = UUID()
        self.url = url
        self.name = ""
        self.description = ""
        self.wikiUrl = ""
    }
    
    init(url: String, name: String, description: String, wikiUrl: String) {
        self.id = UUID()
        self.url = url
        self.name = name
        self.description = description
        self.wikiUrl = wikiUrl
    }
}

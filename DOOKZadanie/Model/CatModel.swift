//
//  CatModel.swift
//  DOOKZadanie
//
//  Created by Przemysław Woźny on 16/12/2021.
//

import Foundation

struct Breed : Decodable {
    let name : String?
    let description: String?
    let wikipedia_url: String?
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
    let wiki_url: String
}

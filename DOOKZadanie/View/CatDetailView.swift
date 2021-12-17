//
//  CatDetailView.swift
//  DOOKZadanie
//
//  Created by Przemysław Woźny on 16/12/2021.
//

import SwiftUI

struct CatDetailView: View {
    let name : String
    let picURL : String
    let wikipedia_URL: String
    let description: String
    
    init(name:String,picURL:String,wikipedia_URL:String, description:String) {
        self.name = name
        self.picURL = picURL
        self.wikipedia_URL = wikipedia_URL
        if description == "" {
            self.description = "Cat has no description 😿"
        }else{
            self.description = description
        }
    }
    var body: some View {
        VStack{
            URLImageView(urlString: picURL).padding()
            Text(name)
            if wikipedia_URL != ""{
                Link("Learn more about \(name)", destination: URL(string:wikipedia_URL)!)
            }
            Text(description)

        }
    }
}


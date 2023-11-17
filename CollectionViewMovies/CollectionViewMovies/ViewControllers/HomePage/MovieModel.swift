//
//  MovieModel.swift
//  CollectionViewMovies
//
//  Created by Levan Loladze on 03.11.23.
//


import UIKit

//MARK: 🏃‍♂️ Model

struct MovieFetchedModel: Codable {
    
    struct Movie: Codable {
        let Title: String
        let Poster: String
    }
    
    var totalResults: String = ""
    var Response: String = ""
    var Search: [Movie] = []
}

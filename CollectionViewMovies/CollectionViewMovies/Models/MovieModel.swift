//
//  MovieModel.swift
//  CollectionViewMovies
//
//  Created by Levan Loladze on 03.11.23.
//


import UIKit


struct MovieFetchedModel: Codable {
    
    struct Movie: Codable {
        let Title: String
        let Poster: String
        
    }
    
    let totalResults: String
    let Response: String
    let Search: [Movie]
}

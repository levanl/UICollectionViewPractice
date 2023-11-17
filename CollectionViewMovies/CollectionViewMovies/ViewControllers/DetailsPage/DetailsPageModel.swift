//
//  DetailsPageModel.swift
//  CollectionViewMovies
//
//  Created by Levan Loladze on 17.11.23.
//

import UIKit


//MARK: 📁 Model

final class DetailsPageModel {
    
    var movieTitle: String
    var movieImage: String

    init(movieTitle: String, movieImage: String) {
        self.movieTitle = movieTitle
        self.movieImage = movieImage
    }
}

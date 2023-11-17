//
//  DetailsPageViewModel.swift
//  CollectionViewMovies
//
//  Created by Levan Loladze on 17.11.23.
//

import UIKit

//MARK: 📁 ViewModel
final class DetailsPageViewModel {
    
    private var model: DetailsPageModel

    var movieTitle: String {
        return model.movieTitle
    }
    
    var movieImage: String {
        return model.movieImage
    }

    init(model: DetailsPageModel) {
        self.model = model
    }
    
    func getModel() -> DetailsPageModel {
        return model
    }
}

//
//  MovieViewModel.swift
//  CollectionViewMovies
//
//  Created by Levan Loladze on 17.11.23.
//

import Foundation


// MARK: 🏃‍♂️ ViewModel

final class MovieViewModel {
    
    private let movieFetchedModel: MovieFetchedModel
    
    var movies: [MovieFetchedModel.Movie] = []
    
    init(movieFetchedModel: MovieFetchedModel) {
        self.movieFetchedModel = movieFetchedModel
    }
    
    var totalResults: String {
        return movieFetchedModel.totalResults
    }
    
    var response: String {
        return movieFetchedModel.Response
    }
    
    func fetchMovies(completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                let fetchedMovies = try await MovieService.getMovies()
                updateMovies(with: fetchedMovies)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func updateMovies(with fetchedMovies: MovieFetchedModel) {
        movies = fetchedMovies.Search
    }
    
}

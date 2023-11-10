//
//  MovieService.swift
//  CollectionViewMovies
//
//  Created by Levan Loladze on 11.11.23.
//

import Foundation
import UIKit

class MovieService {
    static func getMovies() async throws -> MovieFetchedModel {
        let endpoint = "https://www.omdbapi.com/?apikey=26d7f57b&s=action"
        
        guard let url = URL(string: endpoint) else { throw MovieError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw MovieError.invalidResponse }
        
        //        print(String(data: data, encoding: .utf8) ?? "Invalid data")
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(MovieFetchedModel.self, from: data)
        } catch {
            if let decodingError = error as? DecodingError {
                print("Decoding Error: \(decodingError)")
            }
            throw MovieError.invalidData
        }
    }
    
    static func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageCache.storeImage(urlString: urlString, img: image)
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}


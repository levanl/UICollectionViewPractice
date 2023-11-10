//
//  MovieDetailViewController.swift
//  CollectionViewMovies
//
//  Created by Levan Loladze on 04.11.23.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let movieView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .red
        return imageView
    }()
    
    
    private let movieRatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    
    private let selectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select session", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 252/255.0, green: 119/255.0, blue: 41/255.0, alpha: 1)
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        return button
    }()
    
    
    // MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 29/255.0, green: 39/255.0, blue: 58/255.0, alpha: 1)
        setupDetailUi()
    }
    
    // MARK: - Setup UI
    
    private func setupDetailUi() {
        setupMovieTitle()
        setupMovieView()
        setupMovieRatingStackView()
        setupSelectButton()
    }
    
    
    private func setupMovieView() {
        view.addSubview(movieView)
        
        NSLayoutConstraint.activate([
            movieView.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 23),
            movieView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    // MARK: - Configure Method
    
    func configure(with model: MovieFetchedModel.Movie) {
        movieTitle.text = model.Title
        MovieService.loadImage(from: model.Poster) { [weak self] image in
            DispatchQueue.main.async {
                self?.movieView.image = image
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupMovieTitle() {
        view.addSubview(movieTitle)
        
        NSLayoutConstraint.activate([
            movieTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23)
        ])
    }
    
    private func setupMovieRatingStackView() {
        view.addSubview(movieRatingStackView)
        
        NSLayoutConstraint.activate([
            movieRatingStackView.topAnchor.constraint(equalTo: movieView.bottomAnchor, constant: 12),
            movieRatingStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupSelectButton() {
        view.addSubview(selectButton)
        
        NSLayoutConstraint.activate([
            selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            selectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
}

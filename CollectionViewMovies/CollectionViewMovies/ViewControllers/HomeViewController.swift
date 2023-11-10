//
//  HomeViewController.swift
//  CollectionViewMovies
//
//  Created by Levan Loladze on 03.11.23.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var movieData: MovieFetchedModel?
    
    private let navigationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .left
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Profile", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 77).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.backgroundColor = UIColor(red: 252/255.0, green: 119/255.0, blue: 41/255.0, alpha: 1)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 29/255.0, green: 39/255.0, blue: 58/255.0, alpha: 1)
        
        return collectionView
    }()
    
    // MARK: - Movies Array
    
    private var movies: [MovieFetchedModel.Movie] = []
    
    // MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 29/255.0, green: 39/255.0, blue: 58/255.0, alpha: 1)
        setupUI()
        
        Task {
            do {
                let fetchedMovies = try await MovieService.getMovies()
                updateUI(with: fetchedMovies)
                print(fetchedMovies)
            } catch {
                print("Error fetching movies: \(error)")
            }
        }
        
    }
    
    // MARK: UI Setup
    
    private func setupUI() {
        setupStackView()
        setupCollectionView()
    }
    
    func updateUI(with fetchedMovies: MovieFetchedModel) {
        movies = fetchedMovies.Search
        moviesCollectionView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func setupStackView() {
        view.addSubview(navigationStackView)
        
        navigationStackView.addArrangedSubview(logoImageView)
        navigationStackView.addArrangedSubview(profileButton)
        
        NSLayoutConstraint.activate([
            navigationStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            navigationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
    }
    
    private func setupCollectionView() {
        view.addSubview(moviesCollectionView)
        
        if let layout = moviesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: (view.frame.width / 2) - 24, height: 278)
        }
        
        NSLayoutConstraint.activate([
            moviesCollectionView.topAnchor.constraint(equalTo: navigationStackView.bottomAnchor, constant: 16),
            moviesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            moviesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        moviesCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
    }
    
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movies[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell{
            cell.configure(with: movie)
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("movie \(indexPath.row) is tapped")
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.configure(with: movies[indexPath.row])
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
}



// MARK: Error Cases

enum MovieError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

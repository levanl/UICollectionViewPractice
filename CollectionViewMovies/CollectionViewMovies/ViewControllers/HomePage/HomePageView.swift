//
//  HomeViewController.swift
//  CollectionViewMovies
//
//  Created by Levan Loladze on 03.11.23.
//

import UIKit


// MARK: 👉 View

final class HomeView: UIView {
    
    // MARK: 👉 Properties
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
    
    let moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 29/255.0, green: 39/255.0, blue: 58/255.0, alpha: 1)
        
        return collectionView
    }()
    
    // MARK: 👉 Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 👉 SetupUI
    func setupUI() {
        setupStackView()
        setupCollectionView()
    }
    
    // MARK: 👉 UI Functions
    private func setupStackView() {
        addSubview(navigationStackView)
        
        navigationStackView.addArrangedSubview(logoImageView)
        navigationStackView.addArrangedSubview(profileButton)
        
        NSLayoutConstraint.activate([
            navigationStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            navigationStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let layout = moviesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: (self.frame.width / 2) - 24, height: 278)
        }
    }
    
    private func setupCollectionView() {
        addSubview(moviesCollectionView)
        
        moviesCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        
        NSLayoutConstraint.activate([
            moviesCollectionView.topAnchor.constraint(equalTo: navigationStackView.bottomAnchor, constant: 16),
            moviesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            moviesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            moviesCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
    }
}





//MARK: 👉 ViewController
final class HomeViewController: UIViewController {
    
    // MARK: 👉 Properties
    var itemView: HomeView
    var viewModel: MovieViewModel
    var movies: [MovieFetchedModel.Movie] = []
    
    // MARK: 👉 Init
    init() {
        self.itemView = HomeView()
        viewModel = MovieViewModel(movieFetchedModel: MovieFetchedModel())
        super.init(nibName: nil, bundle: nil)
        itemView.moviesCollectionView.delegate = self
        itemView.moviesCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = itemView
        view.backgroundColor = UIColor(red: 29/255.0, green: 39/255.0, blue: 58/255.0, alpha: 1)
        viewModel.fetchMovies { [weak self] result in
            switch result {
            case .success:
                self?.updateView()
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateView() {
        movies = viewModel.movies
        
        DispatchQueue.main.async { [weak self] in
            self?.itemView.moviesCollectionView.reloadData()
        }
    }
    
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: 👉 CollectionView DataSource
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
    
    // MARK: 👉 CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailsPageModel = DetailsPageModel(
            movieTitle: movies[indexPath.row].Title,
            movieImage: movies[indexPath.row].Poster
        )
        
        let detailsPageViewModel = DetailsPageViewModel(model: detailsPageModel)
        let detailsPageVC = MovieDetailViewController(viewModel: detailsPageViewModel)
        detailsPageVC.detailsView.configure(with: detailsPageModel)
        navigationController?.pushViewController(detailsPageVC, animated: true)
    }
    
}



// MARK: 🛑 Error Cases
enum MovieError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

//
//  HomeViewController.swift
//  CollectionViewMovies
//
//  Created by Levan Loladze on 03.11.23.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    // MARK: - Properties
    
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
    
    private var movies = [
        Movie(image: UIImage(named: "Batman"), title: "The Batman", genre: "Action", rating: 8.1, description: "When the Riddler, a sadistic serial killer, begins murdering key political figures in Gotham, Batman is forced to investigate the city's hidden corruption and question his family's involvement."),
        Movie(image: UIImage(named: "Uncharted"), title: "Uncharted", genre: "Adventure", rating: 7.9, description: "Street-smart Nathan Drake is recruited by seasoned treasure hunter Victor  Sullivan to recover a fortune amassed by Ferdinand Magellan, and lost 500 years ago by the House of Moncada."),
        Movie(image: UIImage(named: "SpiderMan"), title: "Spider-Man: No Way Home", genre: "Action", rating: 8.1, description: "When a spell goes wrong, dangerous foes from other worlds start to appear, forcing Peter to discover what it truly means to be Spider-Man. Peter Parker's secret identity is revealed to the entire world. Desperate for help, Peter turns to Doctor Strange to make the world forget that he is Spider-Man."),
        Movie(image: UIImage(named: "Exorcism"), title: "The Exorcism of God", genre: "Horror", rating: 5.6, description: "Peter Williams, an American priest working in Mexico, is possessed during an exorcism and ends up committing a terrible act. Eighteen years later, the consequences of his sin come back to haunt him, unleashing the greatest battle within."),
        Movie(image: UIImage(named: "Southpaw"), title: "Southpaw", genre: "Action", rating: 5.6, description: "a boxer who sets out to get his life back on track after losing his wife in an accident and his young daughter to protective services."),
        Movie(image: UIImage(named: "Rocky"), title: "Rocky Balboa", genre: "Action", rating: 5.6, description: "Rocky Balboa (Stallone), now an aging small restaurant owner, is challenged to an exhibition fight by hothead young boxer Mason Dixon (Tarver).")
    ]
    
    // MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 29/255.0, green: 39/255.0, blue: 58/255.0, alpha: 1)
        setupUI()
    }
    
    // MARK: UI Setup
    
    private func setupUI() {
        setupStackView()
        setupCollectionView()
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
            layout.itemSize = CGSize(width: 164, height: 278)
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

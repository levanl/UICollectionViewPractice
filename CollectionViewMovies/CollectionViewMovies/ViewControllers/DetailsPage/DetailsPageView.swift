//
//  MovieDetailViewController.swift
//  CollectionViewMovies
//
//  Created by Levan Loladze on 04.11.23.
//

import UIKit


// MARK: 👉 View
final class DetailView: UIView {
    
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
    
    // MARK: 👉 Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupDetailUi()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: 👉 Configure
    func configure(with model: DetailsPageModel) {
        movieTitle.text = model.movieTitle
        MovieService.loadImage(from: model.movieImage) { [weak self] image in
            DispatchQueue.main.async {
                self?.movieView.image = image
            }
        }
    }
    
    private func setupDetailUi() {
        setupMovieTitle()
        setupMovieView()
        setupMovieRatingStackView()
        setupSelectButton()
    }
    
    private func setupMovieTitle() {
        addSubview(movieTitle)
        
        NSLayoutConstraint.activate([
            movieTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            movieTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 23)
        ])
    }
    
    private func setupMovieRatingStackView() {
        addSubview(movieRatingStackView)
        
        NSLayoutConstraint.activate([
            movieRatingStackView.topAnchor.constraint(equalTo: movieView.bottomAnchor, constant: 12),
            movieRatingStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupSelectButton() {
        addSubview(selectButton)
        
        NSLayoutConstraint.activate([
            selectButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            selectButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            selectButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func setupMovieView() {
        addSubview(movieView)
        
        NSLayoutConstraint.activate([
            movieView.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 23),
            movieView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}

// MARK: 👉 ViewController
final class MovieDetailViewController: UIViewController {
    
    // MARK: 👉 Properties
    var detailsView: DetailView
    var viewModel: DetailsPageViewModel
    
    // MARK: 👉 Init
    init(viewModel: DetailsPageViewModel) {
        self.viewModel = viewModel
        self.detailsView = DetailView()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = detailsView
        view.backgroundColor = UIColor(red: 29/255.0, green: 39/255.0, blue: 58/255.0, alpha: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 👉 ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



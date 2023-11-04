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
        imageView.heightAnchor.constraint(equalToConstant: 210).isActive = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    
    private var movieRatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let imdb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "IMDB"
        return label
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
    
    private let movieDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let certificateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Certificate"
        return label
    }()
    
    private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "runtime"
        return label
    }()
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "release"
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "director"
        return label
    }()
    
    private let castLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "cast"
        return label
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
    
    // stackView ების ერთმანეთში დანესტვა ვცადე , მაგრამ რატომღაც არ აჩენდა, ეხა ძალიან დავიღალე და ხვალ გავარკვევ ;დდდ
    
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
        setupDetailsView()
        setupSelectButton()
    }

    
    private func setupMovieView() {
        view.addSubview(movieView)
        
        NSLayoutConstraint.activate([
            movieView.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 23),
            movieView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupDetailsView() {
        view.addSubview(movieDescriptionStackView)
        
        movieDescriptionStackView.addArrangedSubview(certificateLabel)
        movieDescriptionStackView.addArrangedSubview(runtimeLabel)
        movieDescriptionStackView.addArrangedSubview(releaseLabel)
        movieDescriptionStackView.addArrangedSubview(directorLabel)
        movieDescriptionStackView.addArrangedSubview(castLabel)
        
        NSLayoutConstraint.activate([
            movieDescriptionStackView.topAnchor.constraint(equalTo: movieRatingStackView.bottomAnchor, constant: 23),
            movieDescriptionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieDescriptionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Configure Method
    
    func configure(with model: Movie) {
        movieView.image = model.image
        movieTitle.text = model.title
        movieRatingLabel.text = String(model.rating)
        //movieDescription.text = model.description
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
        
        movieRatingStackView.addArrangedSubview(movieRatingLabel)
        movieRatingStackView.addArrangedSubview(imdb)
        
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

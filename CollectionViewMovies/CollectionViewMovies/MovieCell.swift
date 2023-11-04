//
//  MovieCell.swift
//  CollectionViewMovies
//
//  Created by Levan Loladze on 03.11.23.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    
    // MARK: - Identifier
    
    static let identifier = "MovieCell"
    
    
    // MARK: - Properties
    
    private let movieImageViewCont: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 164).isActive = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let movieDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let movieGenreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        
        label.textColor = UIColor(red: 99, green: 115, blue: 148, alpha: 1)
        
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - ViewLifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup UI
    
    private func setupCellUI() {
        setupMovieImageView()
        addSubview(heartButton)
        setupStackView()
    }
    
    // MARK: - Private Methods
    private func setupMovieImageView() {
        addSubview(movieImageViewCont)
        addSubview(heartButton)
        
        NSLayoutConstraint.activate([
            movieImageViewCont.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageViewCont.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageViewCont.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            heartButton.topAnchor.constraint(equalTo: movieImageViewCont.topAnchor, constant: 8),
            heartButton.leadingAnchor.constraint(equalTo: movieImageViewCont.leadingAnchor, constant: 8),
            heartButton.widthAnchor.constraint(equalToConstant: 32),
            heartButton.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        heartButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc func likeButtonTapped() {
        heartButton.isSelected = !heartButton.isSelected
        
        if heartButton.isSelected {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
    
    private func setupStackView() {
        addSubview(movieDescriptionStackView)
        
        
        movieDescriptionStackView.addArrangedSubview(movieTitleLabel)
        movieDescriptionStackView.addArrangedSubview(movieGenreLabel)
        
        NSLayoutConstraint.activate([
            movieDescriptionStackView.topAnchor.constraint(equalTo: movieImageViewCont.bottomAnchor, constant: 8),
            movieDescriptionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieDescriptionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    
    // MARK: - Configure Method
    
    func configure(with model: Movie) {
        movieImageViewCont.image = model.image
        movieTitleLabel.text = model.title
        movieGenreLabel.text = model.genre
    }
}

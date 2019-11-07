//
//  movieVCViewController.swift
//  KaduregelStats
//
//  Created by User on 06/11/2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class movieVCViewController: UIViewController {

    var movieDetail: MovieDetailes! = nil
    
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.loadImageUsingCatchWithUrlString(URLString: movieDetail.posterPath)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let movieDetailsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    private let movieNameLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont(name: "Arial", size: 30.0)
        lb.textAlignment = .center
        
        return lb
    }()
    
    private lazy var movieGenreLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont(name: "Arial", size: 20.0)
        lb.text = "Genre: \(movieDetail.gender)"
        
        return lb
    }()
    
    private let genreSepratorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1)
        return view
    }()
    
    private lazy var movieRatingLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont(name: "Arial", size: 20.0)
        lb.text = "Rating: \(movieDetail.voteAvg)"
        
        return lb
    }()
    
    private let ratingSepratorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1)
        
        return view
    }()
    
    private lazy var movieReleaseYearLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont(name: "Arial", size: 20.0)
        lb.text = "Release date: \(movieDetail.realeaseDate)"
        
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        view.addSubviews(movieImage, movieNameLabel, movieDetailsContainerView)
        
        movieImageAnchor()
        movieNameLabelAnchor()
        MovieDetailsContainerViewAnchor()
        self.title = "Details"
        
    }
    
    func movieImageAnchor() {
        
        let movieImageHeight: CGFloat = 200
        let centerMovieImage: CGFloat = view.frame.width/2 - movieImageHeight/2
        
        movieImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 12, left: centerMovieImage, bottom: 0, right: 0), size: CGSize(width: movieImageHeight, height: movieImageHeight))
    }
    
    func movieNameLabelAnchor() {
        movieNameLabel.text = movieDetail.title
        
        movieNameLabel.anchor(top: movieImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5), size: CGSize(width: view.frame.width - 10, height: 80))
        
    }
    
    func MovieDetailsContainerViewAnchor(){
        
        let movieDetailsContainerViewWidth = view.frame.width - 24
        let movieDetailsContainerViewHeight: CGFloat = 201
        
        movieDetailsContainerView.anchor(top: movieNameLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 12, bottom: 0, right: 0), size: CGSize(width: movieDetailsContainerViewWidth, height: movieDetailsContainerViewHeight))
        
        movieDetailsContainerView.addSubviews(movieGenreLabel, genreSepratorView, movieRatingLabel, ratingSepratorView, movieReleaseYearLabel)
        
        movieGenreLabel.anchor(top: movieDetailsContainerView.topAnchor, leading: movieDetailsContainerView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0), size: CGSize(width: movieDetailsContainerViewWidth, height: movieDetailsContainerViewHeight/3))
        
        genreSepratorView.anchor(top: movieGenreLabel.bottomAnchor, leading: movieDetailsContainerView.leadingAnchor, bottom: nil, trailing: nil, size: CGSize(width: movieDetailsContainerViewWidth, height: 1))
        
        movieRatingLabel.anchor(top: genreSepratorView.topAnchor, leading: movieDetailsContainerView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0), size: CGSize(width: movieDetailsContainerViewWidth, height: movieDetailsContainerViewHeight/3))
        
        ratingSepratorView.anchor(top: movieRatingLabel.bottomAnchor, leading: movieDetailsContainerView.leadingAnchor, bottom: nil, trailing: nil, size: CGSize(width: movieDetailsContainerViewWidth, height: 1))
        
        movieReleaseYearLabel.anchor(top: ratingSepratorView.topAnchor, leading: movieDetailsContainerView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0), size: CGSize(width: movieDetailsContainerViewWidth, height: movieDetailsContainerViewHeight/3))

    }
}

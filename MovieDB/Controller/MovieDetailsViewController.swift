//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UITableViewController {
    
    var movieTitle = ""
    var moviePosterPath = ""
    var movieId = -1
    var movieSynopsis = ""
    var movieReviews = [ReviewsDetails]()
    var movieCredits = [CreditDetails]()
    var similarMovies = [SimilarMovieDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.contentInset = UIEdgeInsets(top: -UIApplication.shared.keyWindow!.safeAreaInsets.top, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor(red: 51/255, green: 53/255, blue: 68/255, alpha: 1.0)
        tableView.allowsSelection = false
        tableView.bounces = false
        registerCells()
        downloadSynopsisForMovie()
        downloadReviewsForMovie()
        downloadCreditsForMovie()
        downloadSimilarMoviesForMovie()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    func registerCells() {
        
        tableView.register(MovieCoverCell.self, forCellReuseIdentifier: GlobalConstants.MOVIE_COVER_CELL_REUSE_IDENTIFIER)
        tableView.register(MovieSynopsisCell.self, forCellReuseIdentifier: GlobalConstants.MOVIE_SYNOPSIS_CELL_REUSE_IDENTIFIER)
        tableView.register(MovieReviewCell.self, forCellReuseIdentifier: GlobalConstants.MOVIE_REVIEW_CELL_REUSE_IDENTIFIER)
        tableView.register(MovieCreditCell.self, forCellReuseIdentifier: GlobalConstants.MOVIE_CREDIT_CELL_REUSE_IDENTIFIER)
        tableView.register(SimilarMovieCell.self, forCellReuseIdentifier: GlobalConstants.SIMILAR_MOVIE_CELL_REUSE_IDENTIFIER)
    }
    
    func downloadSynopsisForMovie() {
        
        Synopsis.getSynopsis(withId: movieId) { (synopsis, error, errorString) in
            guard let synopsis = synopsis else { return }
            self.movieSynopsis = synopsis.synopsis
            self.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
        }
    }
    
    func downloadReviewsForMovie() {
        
        Review.getReviews(withPage: 1, withId: movieId) { (review, error, errorString) in
            guard let review = review else { return }
            guard let results = review.results else { return }
            self.movieReviews = results
            self.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .none)
        }
    }
    
    func downloadCreditsForMovie() {
        
        Credit.getCredits(withId: movieId) { (credit, error, errorString) in
            guard let credit = credit else { return }
            guard let results = credit.results else { return }
            self.movieCredits = results
            self.tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .none)
        }
    }
    
    func downloadSimilarMoviesForMovie() {
        
        SimilarMovie.getSimilarMovies(withPage: 1, withId: movieId) { (similarMovie, error, errorString) in
            guard let similarMovie = similarMovie else { return }
            guard let results = similarMovie.results else { return }
            self.similarMovies = results
            self.tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .none)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case 0:
            return view.frame.width * 1.3
            
        case 1...3:
            return UITableView.automaticDimension
            
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.MOVIE_COVER_CELL_REUSE_IDENTIFIER, for: indexPath) as! MovieCoverCell
            
            cell.setupViews()
            
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.posterImageView.image = #imageLiteral(resourceName: "thumbnail")
            
            APIClient.downloadImage(moviePosterPath, original: true) { (downloadedImage) in
                DispatchQueue.main.async {
                    if let visibleCell = tableView.cellForRow(at: indexPath) as? MovieCoverCell {
                        visibleCell.posterImageView.image = downloadedImage
                    }
                }
            }
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.MOVIE_SYNOPSIS_CELL_REUSE_IDENTIFIER, for: indexPath) as! MovieSynopsisCell
            
            cell.setupViews()
            cell.synopsisLabel.text = movieSynopsis
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.MOVIE_REVIEW_CELL_REUSE_IDENTIFIER, for: indexPath) as! MovieReviewCell
            
            if movieReviews.count > 0 {
                cell.reviewDetails = movieReviews
                cell.setupViews()
            }
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.MOVIE_CREDIT_CELL_REUSE_IDENTIFIER, for: indexPath) as! MovieCreditCell
            
            if movieCredits.count > 0 {
                cell.creditDetails = movieCredits
                cell.setupViews()
            }
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.SIMILAR_MOVIE_CELL_REUSE_IDENTIFIER, for: indexPath) as! SimilarMovieCell
            
            if similarMovies.count > 0 {
                cell.movieDetails = similarMovies
                cell.setupViews()
            }
            
            return cell
        }
    }

}

//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UITableViewController, MoviewCoverCellDelegate, MovieReviewCellDelegate, SimilarMovieCellDelegate {
    
    
    //MARK: - Properties & Variables
    
    var moviePosterPath = ""
    var movieId = -1
    var movieSynopsis = ""
    var movieReviews = [ReviewsDetails]()
    var movieReviewsPageNumber = 1
    var movieReviewsTotalPages = 1
    var movieCredits = [CreditDetails]()
    var similarMovies = [SimilarMovieDetails]()
    var similarMoviesPageNumber = 1
    var similarMoviesTotalPages = 1
    
    let progressView = ProgressBar(text: "Loading....")
    
    
    //MARK: - View Controller Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.contentInset = UIEdgeInsets(top: -UIApplication.shared.keyWindow!.safeAreaInsets.top, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor(red: 51/255, green: 53/255, blue: 68/255, alpha: 1.0)
        tableView.allowsSelection = false
        tableView.bounces = false
        registerCells()
        downloadData()
    }
    
    
    //MARK: - Status bar related methods
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    
    //MARK: - Method to register table view cells
    
    func registerCells() {
        
        tableView.register(MovieCoverCell.self, forCellReuseIdentifier: GlobalConstants.MOVIE_COVER_CELL_REUSE_IDENTIFIER)
        tableView.register(MovieSynopsisCell.self, forCellReuseIdentifier: GlobalConstants.MOVIE_SYNOPSIS_CELL_REUSE_IDENTIFIER)
        tableView.register(MovieReviewCell.self, forCellReuseIdentifier: GlobalConstants.MOVIE_REVIEW_CELL_REUSE_IDENTIFIER)
        tableView.register(MovieCreditCell.self, forCellReuseIdentifier: GlobalConstants.MOVIE_CREDIT_CELL_REUSE_IDENTIFIER)
        tableView.register(SimilarMovieCell.self, forCellReuseIdentifier: GlobalConstants.SIMILAR_MOVIE_CELL_REUSE_IDENTIFIER)
    }
    
    
    //MARK: - Methods to download data related to movie
    
    func downloadData() {
        
        downloadSynopsisForMovie()
        downloadReviewsForMovie()
        downloadCreditsForMovie()
        downloadSimilarMoviesForMovie()
    }
    
    func downloadSynopsisForMovie() {
        
        Synopsis.getSynopsis(withId: movieId) { (synopsis, error, errorString) in
            if !error {
                guard let synopsis = synopsis else { return }
                self.movieSynopsis = synopsis.synopsis
                self.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
            } else {
                AlertView.showAlert(inVC: self, withMessage: errorString)
            }
        }
    }
    
    func downloadReviewsForMovie() {
        
        movieReviewsPageNumber = 1
        
        Review.getReviews(withPage: movieReviewsPageNumber, withId: movieId) { (review, error, errorString) in
            if !error {
                guard let review = review else { return }
                guard let results = review.results else { return }
                self.movieReviews = results
                self.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .none)
            } else {
                AlertView.showAlert(inVC: self, withMessage: errorString)
            }
        }
    }
    
    func downloadCreditsForMovie() {
        
        Credit.getCredits(withId: movieId) { (credit, error, errorString) in
            if !error {
                guard let credit = credit else { return }
                guard let results = credit.results else { return }
                self.movieCredits = results
                self.tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .none)
            } else {
                AlertView.showAlert(inVC: self, withMessage: errorString)
            }
        }
    }
    
    func downloadSimilarMoviesForMovie() {
        
        similarMoviesPageNumber = 1
        
        SimilarMovie.getSimilarMovies(withPage: similarMoviesPageNumber, withId: movieId) { (similarMovie, error, errorString) in
            if !error {
                guard let similarMovie = similarMovie else { return }
                guard let results = similarMovie.results else { return }
                self.similarMovies = results
                self.tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .none)
            } else {
                AlertView.showAlert(inVC: self, withMessage: errorString)
            }
        }
    }
    
    
    //MARK: - Movie Cover Cell Delegate Method
    
    func didTapDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Movie Review Cell Delegate Method
    
    func loadMoreReviews() {
        
        movieReviewsPageNumber += 1
        
        if movieReviewsPageNumber <= movieReviewsTotalPages {
            
            Review.getReviews(withPage: 1, withId: movieId) { (review, error, errorString) in
                if !error {
                    guard let review = review else { return }
                    guard let results = review.results else { return }
                    self.movieReviews.append(contentsOf: results)
                    guard let cell = self.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? MovieReviewCell else { return }
                    cell.reviewDetails = self.movieReviews
                    cell.reviewCollectionView.reloadData()
                } else {
                    AlertView.showAlert(inVC: self, withMessage: errorString)
                }
            }
        }
    }
    
    
    //MARK: - Similar Movie Cell Delegate Method
    
    func loadMoreSimilarMovies() {
        
        similarMoviesPageNumber += 1
        
        if similarMoviesPageNumber <= similarMoviesTotalPages {
            
            SimilarMovie.getSimilarMovies(withPage: similarMoviesPageNumber, withId: movieId) { (similarMovie, error, errorString) in
                if !error {
                    guard let similarMovie = similarMovie else { return }
                    guard let results = similarMovie.results else { return }
                    self.similarMovies.append(contentsOf: results)
                    guard let cell = self.tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as? SimilarMovieCell else { return }
                    cell.movieDetails = self.similarMovies
                    cell.moviesCollectionView.reloadData()
                } else {
                    AlertView.showAlert(inVC: self, withMessage: errorString)
                }
            }
        }
    }
    
    
    //MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case 0:
            return view.frame.width * 1.3
            
        case 1:
            if movieSynopsis == "" {
                return 0
            }
            return UITableView.automaticDimension
            
        case 2:
            if movieReviews.count == 0 {
                return 0
            }
            return UITableView.automaticDimension
            
        case 3:
            if movieCredits.count == 0 {
                return 0
            }
            return UITableView.automaticDimension
            
        default:
            if similarMovies.count == 0 {
                return 0
            }
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.MOVIE_COVER_CELL_REUSE_IDENTIFIER, for: indexPath) as! MovieCoverCell
            
            cell.delegate = self
            cell.setupViews()
            
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.posterImageView.image = #imageLiteral(resourceName: "thumbnail")
            
            view.addSubview(progressView)
            
            APIClient.downloadImage(moviePosterPath, original: true) { (downloadedImage) in
                DispatchQueue.main.async {
                    
                    self.progressView.hide()
                    if let visibleCell = tableView.cellForRow(at: indexPath) as? MovieCoverCell {
                        visibleCell.posterImageView.image = downloadedImage
                    }
                }
            }
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.MOVIE_SYNOPSIS_CELL_REUSE_IDENTIFIER, for: indexPath) as! MovieSynopsisCell
            
            if movieSynopsis != "" {
                cell.setupViews()
                cell.synopsisLabel.text = movieSynopsis
            }
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.MOVIE_REVIEW_CELL_REUSE_IDENTIFIER, for: indexPath) as! MovieReviewCell
            
            if movieReviews.count > 0 {
                cell.reviewDetails = movieReviews
                cell.delegate = self
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
                cell.delegate = self
                cell.setupViews()
            }
            
            return cell
        }
    }

}

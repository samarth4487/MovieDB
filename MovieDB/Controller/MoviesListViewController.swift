//
//  ViewController.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK:- Properties & Variables
    
    lazy var moviesTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let progressView = ProgressBar(text: "Loading....")
    
    var movies = [Result]()
    var pageNumber = 1
    
    
    //MARK:- View Controller Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        downloadMovieList()
    }
    
    
    //MARK:- Custom Methods
    
    fileprivate func downloadMovieList() {
        /*
         This method downloads first page of the movies.
        */
        
        view.addSubview(progressView)
        
        Movie.getMovies(withPage: 1) {
            (movie, error, errorMessage) in
            self.progressView.hide()
            
            if !error {
                guard let movie = movie else { return }
                guard let results = movie.results else { return }
                self.movies = results
                self.setupViews()
            } else {
                AlertView.showAlert(inVC: self, withMessage: errorMessage)
            }
        }
    }

    fileprivate func setupViews() {
        /*
         This method sets up all the UI elements for the View Controller.
        */
        
        view.addSubview(moviesTableView)
        moviesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        moviesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        moviesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        registerCells()
    }
    
    fileprivate func loadMoreData() {
        /*
         This method fetches next page of movies as the user scrolls down.
        */
        
        pageNumber += 1
        
        Movie.getMovies(withPage: pageNumber) {
            (movie, error, errorMessage) in
            
            if !error {
                guard let movie = movie else { return }
                guard let results = movie.results else { return }
                self.movies.append(contentsOf: results)
                self.moviesTableView.reloadData()
            } else {
                AlertView.showAlert(inVC: self, withMessage: errorMessage)
            }
        }
    }
    
    fileprivate func registerCells() {
        /*
         This method registers table view cells.
        */
        
        moviesTableView.register(MovieCell.self, forCellReuseIdentifier: GlobalConstants.MOVIE_CELL_REUSE_IDENTIFIER)
    }
    
    
    //MARK: - Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]

        let movieDetailsVC = MovieDetailsViewController()
        movieDetailsVC.movieTitle = movie.title
        movieDetailsVC.moviePosterPath = movie.posterPath
        movieDetailsVC.movieId = movie.id

        present(movieDetailsVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.MOVIE_CELL_REUSE_IDENTIFIER, for: indexPath) as! MovieCell
        
        cell.setupViews()
        cell.selectionStyle = .none
        
        let movie = movies[indexPath.row]
        
        cell.titleLabel.text = movie.title
        cell.posterImageView.image = #imageLiteral(resourceName: "thumbnail")
        
        APIClient.downloadImage(movie.posterPath, original: false, andCallback: { (downloadedImage) in
            DispatchQueue.main.async {
                if let visibleCell = tableView.cellForRow(at: indexPath) as? MovieCell {
                    visibleCell.posterImageView.image = downloadedImage
                }
            }
        })
        cell.releaseDateLabel.text = "Released On " + Movie.modifyDateString(withString: movie.releaseDate)
        
        if indexPath.row == movies.count - 1 {
            loadMoreData()
        }
        
        return cell
    }
}

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
    
    var movies = [Result]()
    var pageNumber = 1
    
    
    //MARK:- View Controller Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        downloadMovieList()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK:- Custom Methods
    
    fileprivate func downloadMovieList() {
        /*
         This method downloads first page of the movies.
        */
        
        Movie.getMovies(withPage: 1) {
            (movie, error, errorMessage) in
            if !error {
                guard let movie = movie else { return }
                guard let results = movie.results else { return }
                self.movies = results
                self.setupViews()
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.MOVIE_CELL_REUSE_IDENTIFIER, for: indexPath) as! MovieCell
        cell.setupViews()
        cell.titleLabel.text = movies[indexPath.row].title
        APIClient.downloadImage(movies[indexPath.row].posterPath, original: false, andCallback: { (downloadedImage) in
            cell.posterImageView.image = downloadedImage
        })
        cell.releaseDateLabel.text = "Released On " + Movie.modifyDateString(withString: movies[indexPath.row].releaseDate)
        
        if indexPath.row == movies.count - 1 {
            loadMoreData()
        }
        
        return cell
    }
}

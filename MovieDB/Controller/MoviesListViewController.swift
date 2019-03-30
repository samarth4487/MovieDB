//
//  ViewController.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MovieCellDelegate, UITextFieldDelegate {
    
    
    //MARK:- Properties & Variables
    
    let searchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let searchViewBorder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        return view
    }()
    
    lazy var searchTextField: UITextField = {
        let field = UITextField()
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Search Movies"
        field.borderStyle = .roundedRect
        field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return field
    }()
    
    lazy var moviesTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let backgroundTint: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
        return view
    }()
    
    let bookedView: BookedView = {
        let view = BookedView()
        view.backgroundColor = .white
        return view
    }()
    
    let progressView = ProgressBar(text: "Loading....")
    var searchViewHeightAnchor: NSLayoutConstraint?
    
    var movies = [Result]()
    var filteredMovies = [Result]()
    var totalPages = 1
    var pageNumber = 1
    var isSearching = false
    
    
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
                self.totalPages = movie.totalPages
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
        
        view.addSubview(searchView)
        searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchViewHeightAnchor = searchView.heightAnchor.constraint(equalToConstant: 60)
        searchViewHeightAnchor?.isActive = true
        
        view.addSubview(searchViewBorder)
        searchViewBorder.leadingAnchor.constraint(equalTo: searchView.leadingAnchor).isActive = true
        searchViewBorder.trailingAnchor.constraint(equalTo: searchView.trailingAnchor).isActive = true
        searchViewBorder.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -1).isActive = true
        searchViewBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        searchView.addSubview(searchTextField)
        searchTextField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 20).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -20).isActive = true
        searchTextField.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 10).isActive = true
        searchTextField.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -20).isActive = true
        
        view.addSubview(moviesTableView)
        moviesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        moviesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        moviesTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor).isActive = true
        moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let tableViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        tableViewTapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tableViewTapGesture)
        
        registerCells()
    }
    
    fileprivate func loadMoreData() {
        /*
         This method fetches next page of movies as the user scrolls down.
        */
        
        pageNumber += 1
        
        if pageNumber <= totalPages {
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
    }
    
    fileprivate func registerCells() {
        /*
         This method registers table view cells.
        */
        
        moviesTableView.register(MovieCell.self, forCellReuseIdentifier: GlobalConstants.MOVIE_CELL_REUSE_IDENTIFIER)
    }
    
    
    //MARK: - Gesture Delegate Methods
    
    @objc func tableViewTapped() {
        
        isSearching = false
        searchTextField.resignFirstResponder()
    }
    
    
    //MARK: - Text Field Delegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        isSearching = true
        filteredMovies = movies
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isSearching = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        isSearching = false
        searchTextField.resignFirstResponder()
        
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text != "" {
            isSearching = true
            filteredMovies = movies.filter({( movie : Result) -> Bool in
                return movie.title.lowercased().contains(textField.text!.lowercased())
            })
        } else {
            filteredMovies = movies
        }
        
        moviesTableView.reloadData()
        
        if filteredMovies.count != 0 {
            
            let indexPath = IndexPath(row: 0, section: 0)
            self.moviesTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    
    //MARK: - Movie Cell Delegate Method
    
    func didTapBook() {
        /*
         This method handle tap on book button and displays a custom modal view
        */
        
        backgroundTint.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(backgroundTint)
        
        bookedView.frame = CGRect(x: backgroundTint.frame.width/2 - 125, y: -300, width: 250, height: 250)
        backgroundTint.addSubview(bookedView)
        bookedView.setupViews()
        
        // Handle show and hide animations for background tint & custom modal
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.bookedView.frame.origin.y = self.backgroundTint.frame.height/2 - 125
        }) { (complete) in
            if complete {
                UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve, animations: {
                    self.bookedView.tickImageView.alpha = 1
                }, completion: { (complete) in
                    if complete {
                        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve, animations: {
                            self.bookedView.messageLabel.alpha = 1
                        }, completion: { (complete) in
                            UIView.animate(withDuration: 0.2, delay: 1, options: .curveEaseInOut, animations: {
                                self.bookedView.frame.origin.y = self.backgroundTint.frame.height + 100
                            }, completion: { (complete) in
                                if complete {
                                    self.bookedView.tickImageView.alpha = 0
                                    self.bookedView.messageLabel.alpha = 0
                                    self.bookedView.tickImageView.removeFromSuperview()
                                    self.bookedView.messageLabel.removeFromSuperview()
                                    self.bookedView.removeFromSuperview()
                                    self.backgroundTint.removeFromSuperview()
                                }
                            })
                        })
                    }
                })
            }
        }
    }
    
    
    //MARK: - Scroll View Delegate Methods
    
    var previousContentOffSetY: CGFloat = 0
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print(scrollView.contentOffset.y)
        
        let presentContentOffsetY = scrollView.contentOffset.y
        
        if presentContentOffsetY >= 0 {
            if presentContentOffsetY > previousContentOffSetY {
                UIView.animate(withDuration: 0.3) {
                    self.searchViewHeightAnchor?.isActive = false
                    self.searchViewHeightAnchor?.constant = 0
                    self.searchViewHeightAnchor?.isActive = true
                    self.view.layoutIfNeeded()
                }
            } else if presentContentOffsetY < previousContentOffSetY {
                UIView.animate(withDuration: 0.3) {
                    self.searchViewHeightAnchor?.isActive = false
                    self.searchViewHeightAnchor?.constant = 60
                    self.searchViewHeightAnchor?.isActive = true
                    self.view.layoutIfNeeded()
                }
            }
            previousContentOffSetY = presentContentOffsetY
        }
    }
    
    
    //MARK: - Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredMovies.count : movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = isSearching ? filteredMovies[indexPath.row] : movies[indexPath.row]

        let movieDetailsVC = MovieDetailsViewController()
        movieDetailsVC.moviePosterPath = movie.posterPath
        movieDetailsVC.movieId = movie.id

        present(movieDetailsVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.MOVIE_CELL_REUSE_IDENTIFIER, for: indexPath) as! MovieCell
        
        cell.delegate = self
        cell.setupViews()
        cell.selectionStyle = .none
        
        let movie = isSearching ? filteredMovies[indexPath.row] : movies[indexPath.row]
        
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
        
        if indexPath.row == movies.count - 3 && !isSearching {
            loadMoreData()
        }
        
        return cell
    }
}

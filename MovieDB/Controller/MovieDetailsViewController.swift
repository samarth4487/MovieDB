//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.contentInset = UIEdgeInsets(top: -UIApplication.shared.keyWindow!.safeAreaInsets.top, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .white
        registerCells()
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case 0:
            return 250
            
        case 1:
            return UITableView.automaticDimension
            
        case 2:
            return 200
            
        case 3:
            return 200
            
        default:
            return 200
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.MOVIE_COVER_CELL_REUSE_IDENTIFIER, for: indexPath) as! MovieCoverCell
            cell.setupViews()
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.MOVIE_SYNOPSIS_CELL_REUSE_IDENTIFIER, for: indexPath) as! MovieSynopsisCell
            cell.setupViews()
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.MOVIE_REVIEW_CELL_REUSE_IDENTIFIER, for: indexPath) as! MovieReviewCell
            cell.setupViews()
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.MOVIE_CREDIT_CELL_REUSE_IDENTIFIER, for: indexPath) as! MovieCreditCell
            cell.setupViews()
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.SIMILAR_MOVIE_CELL_REUSE_IDENTIFIER, for: indexPath) as! SimilarMovieCell
            cell.setupViews()
            return cell
        }
    }

}

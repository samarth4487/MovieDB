//
//  ViewController.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var moviesTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
    }

    func setupViews() {
        
        view.addSubview(moviesTableView)
        moviesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        moviesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        moviesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        registerCells()
    }
    
    func registerCells() {
        
        moviesTableView.register(MovieCell.self, forCellReuseIdentifier: GlobalConstants.MOVIE_CELL_REUSE_IDENTIFIER)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.MOVIE_CELL_REUSE_IDENTIFIER, for: indexPath) as! MovieCell
        cell.setupViews()
        return cell
    }
}


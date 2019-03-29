//
//  SimilarMovieCell.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

class SimilarMovieCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    //MARK: - Properties & Variables
    
    var movieDetails = [SimilarMovieDetails]()
    
    let headingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Recommended Movies"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.showsHorizontalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        view.backgroundColor = UIColor(red: 51/255, green: 53/255, blue: 68/255, alpha: 1.0)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 51/255, green: 53/255, blue: 68/255, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Custom Methods
    
    func setupViews() {
        
        addSubview(headingLabel)
        headingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        headingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        headingLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(moviesCollectionView)
        moviesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        moviesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        moviesCollectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 10).isActive = true
        moviesCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        moviesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
        regsiterCells()
    }
    
    func regsiterCells() {
        
        moviesCollectionView.register(SimilarCollectionCell.self, forCellWithReuseIdentifier: GlobalConstants.SIMILAR_MOVIE_COLLECTION_CELL_REUSE_IDENTIFIER)
    }
    
    
    //MARK: - Collection View Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GlobalConstants.SIMILAR_MOVIE_COLLECTION_CELL_REUSE_IDENTIFIER, for: indexPath) as! SimilarCollectionCell
        
        cell.setupViews()
        
        let movie = movieDetails[indexPath.item]
        cell.movieImageView.image = #imageLiteral(resourceName: "thumbnail")
        
        APIClient.downloadImage(movie.posterPath, original: false) { (downloadedImage) in
            DispatchQueue.main.async {
                cell.movieImageView.image = downloadedImage
            }
        }
        
        cell.movieLabel.text = movie.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

}

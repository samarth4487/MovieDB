//
//  MovieReviewCell.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

protocol MovieReviewCellDelegate {
    
    func loadMoreReviews()
}

class MovieReviewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    //MARK: - Properties & Variables
    
    var reviewDetails = [ReviewsDetails]()
    
    let headingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reviews"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var reviewCollectionView: UICollectionView = {
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
    
    var delegate: MovieReviewCellDelegate?

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
        
        addSubview(reviewCollectionView)
        reviewCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        reviewCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        reviewCollectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 10).isActive = true
        reviewCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        reviewCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
        regsiterCells()
    }
    
    func regsiterCells() {
        
        reviewCollectionView.register(ReviewCollectionCell.self, forCellWithReuseIdentifier: GlobalConstants.REVIEW_COLLECTION_CELL_REUSE_IDENTIFIER)
    }
    
    
    //MARK: - Collection View Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 230, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GlobalConstants.REVIEW_COLLECTION_CELL_REUSE_IDENTIFIER, for: indexPath) as! ReviewCollectionCell
        
        cell.setupViews()
        
        let review = reviewDetails[indexPath.item]
        cell.authorLabel.text = review.author
        cell.reviewLabel.text = review.content
        
        if indexPath.item == reviewDetails.count - 1 {
            if let localDelegate = delegate {
                localDelegate.loadMoreReviews()
            }
        }
        
        return cell
    }

}

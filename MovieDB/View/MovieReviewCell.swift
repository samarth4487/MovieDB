//
//  MovieReviewCell.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

class MovieReviewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let headingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reviews"
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
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(headingLabel)
        headingLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        headingLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(reviewCollectionView)
        reviewCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        reviewCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        reviewCollectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 10).isActive = true
        reviewCollectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        regsiterCells()
    }
    
    func regsiterCells() {
        
        reviewCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "sample")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 200, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sample", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }

}

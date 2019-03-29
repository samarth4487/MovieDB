//
//  MovieDBTests.swift
//  MovieDBTests
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import XCTest
@testable import MovieDB

class MovieDBTests: XCTestCase {

    func testGetMoviesEndpoint() {
        
        var movieList : Movie?
        var isError: Bool?
        
        let expectation = self.expectation(description: "GetMoviesAPI")
        
        Movie.getMovies(withPage: 1) { (movie, error, errorString) in
            movieList = movie
            isError = error
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssert(movieList?.results?.count != 0 && isError == false)
    }
    
    func testGetSynopsisEndpoint() {

        var synopsisData : Synopsis?
        var isError: Bool?

        let expectation = self.expectation(description: "GetSynopsisAPI")

        Synopsis.getSynopsis(withId: 299537) { (synopsis, error, errorString) in
            synopsisData = synopsis
            isError = error
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
        XCTAssert(synopsisData?.synopsis != "" && isError == false)
    }
    
    func testGetReviewsEndpoint() {
        
        var reviewList : Review?
        var isError: Bool?
        
        let expectation = self.expectation(description: "GetReviewsAPI")
        
        Review.getReviews(withPage: 1, withId: 299537) { (review, error, errorString) in
            reviewList = review
            isError = error
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssert(reviewList?.results?.count != 0 && isError == false)
    }
    
    func testGetCreditsEndpoint() {
        
        var creditList : Credit?
        var isError: Bool?
        
        let expectation = self.expectation(description: "GetCreditsAPI")
        
        Credit.getCredits(withId: 299537) { (credit, error, errorString) in
            creditList = credit
            isError = error
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssert(creditList?.results?.count != 0 && isError == false)
    }
    
    func testGetSimilarMoviesEndpoint() {
        
        var similarMoviesList : SimilarMovie?
        var isError: Bool?
        
        let expectation = self.expectation(description: "GetSimilarMoviesAPI")
        
        SimilarMovie.getSimilarMovies(withPage: 1, withId: 299537) { (similarMovie, error, errorString) in
            similarMoviesList = similarMovie
            isError = error
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssert(similarMoviesList?.results?.count != 0 && isError == false)
    }

}

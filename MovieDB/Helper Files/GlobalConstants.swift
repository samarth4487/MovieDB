//
//  GlobalConstants.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import Foundation
import UIKit

struct GlobalConstants {
    
    static let API_RESPONSE_CODE_SUCCESS = 200...210
    static let API_RESPONSE_CODE_NO_INTERNET = 0
    static let API_RESPONSE_CODE_INTERNAL_SERVER_ERROR = 500...505
    static let API_RESPONSE_CODE_BAD_REQUEST = 400...410
    static let API_KEY = "d1d3e6e701db9ef2f11181db40023b93"
    static let BASE_URL = "https://api.themoviedb.org/3/movie"
    static let SMALL_IMAGE_PREFIX = "https://image.tmdb.org/t/p/w500"
    static let ORIGINAL_IMAGE_PREFIX = "https://image.tmdb.org/t/p/original"
    static let SOMETHING_WENT_WRONG_MESSAGE = "Something went wrong"
    static let BAD_REQUEST_MESSAGE = "Bad request"
    static let NO_INTERNET_MESSAGE = "Please connect to the internet"
    static let FAILED_TO_PARSE_JSON_MESSAGE = "Failed to parse JSON"
    
    static let MOVIE_CELL_REUSE_IDENTIFIER = "MOVIE_CELL_REUSE_IDENTIFIER"
    static let MOVIE_COVER_CELL_REUSE_IDENTIFIER = "MOVIE_COVER_CELL_REUSE_IDENTIFIER"
    static let MOVIE_SYNOPSIS_CELL_REUSE_IDENTIFIER = "MOVIE_SYNOPSIS_CELL_REUSE_IDENTIFIER"
    static let MOVIE_REVIEW_CELL_REUSE_IDENTIFIER = "MOVIE_REVIEW_CELL_REUSE_IDENTIFIER"
    static let MOVIE_CREDIT_CELL_REUSE_IDENTIFIER = "MOVIE_CREDIT_CELL_REUSE_IDENTIFIER"
    static let SIMILAR_MOVIE_CELL_REUSE_IDENTIFIER = "SIMILAR_MOVIE_CELL_REUSE_IDENTIFIER"
    static let REVIEW_COLLECTION_CELL_REUSE_IDENTIFIER = "REVIEW_COLLECTION_CELL_REUSE_IDENTIFIER"
    static let CREDIT_COLLECTION_CELL_REUSE_IDENTIFIER = "CREDIT_COLLECTION_CELL_REUSE_IDENTIFIER"
    static let SIMILAR_MOVIE_COLLECTION_CELL_REUSE_IDENTIFIER = "SIMILAR_MOVIE_COLLECTION_CELL_REUSE_IDENTIFIER"
}

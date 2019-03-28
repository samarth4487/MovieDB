//
//  MovieDetails.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import Foundation


struct Synopsis: Decodable {
    
    let synopsis: String
    
    private enum CodingKeys: String, CodingKey {
        case synopsis = "overview"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        synopsis = try values.decodeIfPresent(String.self, forKey: .synopsis) ?? ""
    }
    
    static func getSynopsis(withId id: Int, callback: @escaping (Synopsis?, Bool, String) -> Void) {
        
        let url = URL(string: GlobalConstants.BASE_URL + "/\(id)?api_key=\(GlobalConstants.API_KEY)&language=en-US")
        APIClient.makeRequest(withURL: url!) { (synopsis: Synopsis?, error: Bool, errorMessage: String)  in
            if !error {
                guard let synopsis = synopsis else { return }
                callback(synopsis, error, errorMessage)
            } else {
                callback(nil, error, errorMessage)
            }
        }
    }
}

struct Review: Decodable {
    
    let page: Int
    let totalPages: Int
    let results: [ReviewsDetails]?
    
    private enum CodingKeys: String, CodingKey {
        case page = "page", results = "results", totalPages = "total_pages"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page) ?? 0
        results = try values.decodeIfPresent([ReviewsDetails].self, forKey: .results)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages) ?? 0
    }
    
    static func getReviews(withPage page:Int, withId id: Int, callback: @escaping (Review?, Bool, String) -> Void) {
        
        let url = URL(string: GlobalConstants.BASE_URL + "/\(id)/reviews?api_key=\(GlobalConstants.API_KEY)&page=\(page)&language=en-US")
        APIClient.makeRequest(withURL: url!) { (review: Review?, error: Bool, errorMessage: String)  in
            if !error {
                guard let review = review else { return }
                callback(review, error, errorMessage)
            } else {
                callback(nil, error, errorMessage)
            }
        }
    }
}

struct ReviewsDetails: Decodable {
    
    let author: String
    let content: String
    
    private enum CodingKeys: String, CodingKey {
        case author = "author", content = "content"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decodeIfPresent(String.self, forKey: .author) ?? ""
        content = try values.decodeIfPresent(String.self, forKey: .content) ?? ""
    }
}

struct Credit: Decodable {
    
    let results: [CreditDetails]?
    
    private enum CodingKeys: String, CodingKey {
        case results = "cast"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent([CreditDetails].self, forKey: .results)!
    }
    
    static func getCredits(withId id: Int, callback: @escaping (Credit?, Bool, String) -> Void) {
        
        let url = URL(string: GlobalConstants.BASE_URL + "/\(id)/credits?api_key=\(GlobalConstants.API_KEY)&language=en-US")
        APIClient.makeRequest(withURL: url!) { (credit: Credit?, error: Bool, errorMessage: String)  in
            if !error {
                guard let credit = credit else { return }
                callback(credit, error, errorMessage)
            } else {
                callback(nil, error, errorMessage)
            }
        }
    }
}

struct CreditDetails: Decodable {
    
    let character: String
    let name: String
    let profile_path: String
    
    private enum CodingKeys: String, CodingKey {
        case character = "character", name = "name", profile_path = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        character = try values.decodeIfPresent(String.self, forKey: .character) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        profile_path = try values.decodeIfPresent(String.self, forKey: .profile_path) ?? ""
    }
}

struct SimilarMovie: Decodable {
    
    let page: Int
    let totalPages: Int
    let results: [SimilarMovieDetails]?
    
    private enum CodingKeys: String, CodingKey {
        case page = "page", totalPages = "total_pages", results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page) ?? 0
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages) ?? 0
        results = try values.decodeIfPresent([SimilarMovieDetails].self, forKey: .results)!
    }
    
    static func getSimilarMovies(withPage page: Int, withId id: Int, callback: @escaping (SimilarMovie?, Bool, String) -> Void) {
        
        let url = URL(string: GlobalConstants.BASE_URL + "/\(id)/similar?api_key=\(GlobalConstants.API_KEY)&page=\(page)&language=en-US")
        APIClient.makeRequest(withURL: url!) { (similarMovie: SimilarMovie?, error: Bool, errorMessage: String)  in
            if !error {
                guard let similarMovie = similarMovie else { return }
                callback(similarMovie, error, errorMessage)
            } else {
                callback(nil, error, errorMessage)
            }
        }
    }
}

struct SimilarMovieDetails: Decodable {
    
    let title: String
    let posterPath: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "original_title", posterPath = "poster_path"
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
    }
}
